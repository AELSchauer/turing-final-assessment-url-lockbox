User.create(email: 'a@a.com', password: 'p', password_confirmation: 'p')
User.create(email: 'b@b.com', password: 'p', password_confirmation: 'p')
User.create(email: 'c@c.com', password: 'p', password_confirmation: 'p')
User.create(email: 'd@d.com', password: 'p', password_confirmation: 'p')

User.all.each do |user|
  rand(1..5).times do
    url = Faker::Avatar.image.split('?')[0]
    title = url.split('/')[3].split('.')[0]

    user.links << Link.new(title: title, url: url)
  end
end
