FactoryBot.define do
  factory :user do
    email    { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6, max_length: 128) }
    first_name { Faker::Name.name }
    last_name { Faker::Name.name }
  end
end