FactoryBot.define do
  factory :task do
    user
    title { Faker::Book.title }
    is_done { Faker::Boolean.boolean }
  end
end