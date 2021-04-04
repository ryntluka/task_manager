FactoryBot.define do
  factory :project do
    title { Faker::Book.title }
    position { Faker::Number.number(digits: 4)}
    user
  end
end
