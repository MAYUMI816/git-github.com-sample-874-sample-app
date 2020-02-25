class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.string :name # 名称
      t.text :description #詳細
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
