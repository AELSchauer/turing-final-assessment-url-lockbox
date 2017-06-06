26.times do |l|
  x = (l + 97).chr
  User.create(email: "#{x}@#{x}.com", password: x, password_confirmation: x)
end


User.all.each do |user|
  rand(1..5).times do
    url = Faker::Avatar.image.split('?')[0]
    title = url.split('/')[3].split('.')[0]

    user.links << Link.new(title: title, url: url)
  end
end
