FactoryBot.define do
  factory :user do
    first_name {Faker::Name.first_name}
    last_name {Faker::Name.last_name}
    email {Faker::Internet.email}
    password {Devise.friendly_token.first(8)}

    factory :user_with_tasks do
      transient do
        count { 5 }
      end

      tasks do
        Array.new(count) { association(:task) }
      end
    end
  end
end