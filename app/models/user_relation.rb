class UserRelation < ApplicationRecord
  # 元ユーザ
  belongs_to :user
  # フォローユーザ
  belongs_to :follow, class_name: 'User'

  validates :user_id, presence: true
  validates :follow_id, presence: true
end
