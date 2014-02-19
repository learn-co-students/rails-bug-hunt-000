# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :order do
    aasm_state 'unsubmitted'
  end
end
