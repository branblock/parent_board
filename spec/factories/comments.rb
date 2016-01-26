FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.sentence(word_count = 5) }
    user
    post
  end
end
