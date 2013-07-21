# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  
  factory :user do
    email "test@example.com"
    name "Hugh Jass"
    password "password"
    
    factory :random_user do
      email Faker::Internet.email
    end
  end
end
