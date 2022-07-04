50.times do |n|
  name = Faker::Name.name
  content = "Hogehoge"
  created_at = "Hogehoge"
  updated_at = "Hogehoge"
  deadline = "Hogehoge"
  status = "完了"
  priority = "中"
  Task.create!(name: name,
              content: content,
              created_at: created_at,
              updated_at: updated_at,
              deadline: deadline,
              status: status,
              priority: priority,
              )
end