FactoryBot.define do
  factory :user do
    name { 'endo00' }
    email { 'endo00@example.com' }
    password { 'endo00' }
    admin { true }
  end
  factory :second_user, class: User do
    name { 'endo26' }
    email { 'endo26@example.com' }
    password { 'endo26' }
    admin { false }
  end
end
