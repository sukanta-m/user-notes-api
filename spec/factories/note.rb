FactoryBot.define do
  factory :note do
    title    { Faker::Company.name + Time.now.to_i.to_s }
    body     { Faker::Types.rb_string }
    tag_list { "demo, note" }
    user
  end
end