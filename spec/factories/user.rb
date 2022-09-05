FactoryBot.define do
  factory :user do
    email { Faker::Internet.free_email }
    password { Faker::Internet.password(min_length: 6) }
    name { Faker::Lorem.characters(number:5) }
    sex { 'male' }
    age { 'forties' }
    skin_type { 'dry' }
  end
end