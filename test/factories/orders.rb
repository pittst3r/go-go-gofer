# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :request do
    description Faker::Company.catch_phrase
    user
    
    factory :request_from_random_user do
      association :user, factory: :random_user
    end
  end
end
