class Task < ApplicationRecord
  #default_scope -> { order(created_at: :desc) } #slak C6ヒントより
  
  belongs_to :user
#4. 4. 1 存在性の検証
  validates :user_id, presence: true
  validates :name, presence: true, length: { maximum: 50 } #name属性に50文字以下であること#
  validates :description, presence: true, length: { in: 5..300 }
end


