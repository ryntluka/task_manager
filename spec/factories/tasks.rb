FactoryBot.define do
  factory :task do
    user
    title { Faker::Book.title }
    description { Faker::Lorem.paragraphs(number: 10).join("\n") }
    is_done { Faker::Boolean.boolean }
  end
end