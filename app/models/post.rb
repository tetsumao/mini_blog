class Post < ApplicationRecord
  # 140文字で制限
  validates :content, length: {maximum: 140}

  # ユーザと連携
  belongs_to :user
end
