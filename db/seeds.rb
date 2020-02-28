# coding: utf-8

User.create!( name: "管理者",
              email: "sample@email.com",
              password: "password",
              password_confirmation: "password",
              admin: true)# D4 8. 5. 1 管理権限属性を追加最初のユーザーだけadmin属性をtrueに設
              
60.times do |n|
  name  = Faker::Name.name # サンプルユーザーを100名生成する
  email = "sample-#{n+1}@email.com"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end

# D7 タスクをサンプルとして自動生成する2 ~ 3名のユーザーを対象に、各50タスク程度
Task.create!( task_name: "task1",
             task_description: "タスクの作成")
              
              
users = User.order(:created_at).take  # ①usersに最初の3人だけにタスクを作るように定義
50.times do |n|                           # ②50個のタスクを作成
  task_name =Faker::Lorem.sentence(2)     # ③task_nameとtask_descriptionに内容を定義(Faker::Lorem)
  task_description = Faker::Lorem.sentence(5)
  users.each { |user| user.tasks.create!(task_name: task_name, task_description: task_description) }
# ④usersの繰り返し処理でuserに代入してuserのtaskを作成し内容を(task_name: task_name,task_description: task_description)とする。
end

