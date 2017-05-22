FactoryGirl.define do
  factory :link do
    sequence(:title) { |n| "Robot #{n}" }
    sequence(:url) { |n| "https://robohash.org/robot-#{n}.png" }
    read  false
    user
  end
end
