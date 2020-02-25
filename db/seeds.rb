# coding: utf-8

User.create!( name: "Sample User",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password")
              
60.times do |n|
  name  = Faker::Name.name
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end
# D7 タスクをサンプルとして自動生成する2 ~ 3名のユーザーを対象に、各50タスク程度
@users = User.order(:created_at).take(3)
50.times do |n|
  task_name =Faker::Lorem.sentence(2)
  task_description = Faker::Lorem.sentence(5)
  @users.each { |user| user.tasks.create!(task_name: task_name, task_description: task_description) }
end