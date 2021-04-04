FactoryBot.define do
  factory :tag do
    user
    title { Faker::Book.title }
  end
end
