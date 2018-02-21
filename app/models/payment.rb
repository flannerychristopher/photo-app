class Payment < ApplicationRecord
  attr_accessor :number, :cvc, :exp_month, :exp_year
  belongs_to :user

  def self.month_options
    # Date::MONTHNAMES.compact.map { |name| name.to_s }
    Date::MONTHNAMES.compact.each_with_index.map { |name, i| ["#{i+1} - #{name}", i+1]}
  end

  def self.year_options
    (Date.today.year..(Date.today.year+10)).to_a
  end

  def process_payment
    customer = Stripe::Customer.create  email: email, 
                                        source: token
    Stripe::Charge.create customer: customer.id,
                          amount: 10000,
                          description: 'Premium',
                          currency: 'usd'
                          
  end
end
