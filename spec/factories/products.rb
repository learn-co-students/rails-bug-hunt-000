# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name "MyString"
    serial_number 1
    cost_in_cents 1
    amount_in_stock 1
  end
end
