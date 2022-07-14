10.times do |n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
              email: email,
              password: password,
              )
end

Label.create!(
  name: '本番環境'
)

Label.create!(
  name: '開発'
)

Label.create!(
  name: '設計'
)

Label.create!(
  name: 'テスト'
)