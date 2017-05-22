FactoryGirl.define do
  factory :link do
    robot = Faker::Avatar.image.split("?")[0]

    title robot.split("/")[3].split(".")[0]
    url   robot
    read  false
    user
  end
end
