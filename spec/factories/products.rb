# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :product do
    name Faker::Commerce.product_name
    serial_number Faker::Number.number(10)
    cost_in_cents Faker::Number.number(5)
    amount_in_stock Faker::Number.number(3)
  end
end
