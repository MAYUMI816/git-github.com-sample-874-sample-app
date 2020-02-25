class Task < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  
  belongs_to :user
  
  validates :user_id, presence: true
#4. 4. 1 存在性の検証
  validates :name, presence: true, length: { maximum: 50 } #name属性に50文字以下であること#
  validates :description, presence: true, length: { in: 5..300 }
end