class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :recoverable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable,
         :authentication_keys => [:user_name]
  
  # user_name
  validates_uniqueness_of :user_name
  validates_presence_of :user_name

  # 投稿との連携
  has_many :posts, dependent: :destroy

  # ユーザ関連テーブルとの連携
  has_many :user_relations
  has_many :followings, through: :user_relations, source: :follow

  # emailの検証を無効化
  def email_required?
    false
  end
  def email_changed?
    false
  end
  def will_save_change_to_email?
    false
  end
  
  # アルファベットのみ20字以内
  validates :user_name, format: /\A[a-zA-Z]+\z/, length: {maximum: 20}
  # プロフィールは200文字で制限
  validates :profile, length: {maximum: 200}
  # ブログURL
  validates :blog_url, format: /\A(|#{URI::regexp(%w(http https))})\z/

  # フォローの関係を追加・または取得する
  def follow(user)
    unless self.id == user.id
      self.user_relations.find_or_create_by(follow_id: user.id)
    end
  end

  # フォローを解除する
  def unfollow(user)
    user_relation = self.user_relations.find_by(follow_id: user.id)
    user_relation.destroy if user_relation.present?
  end

  # フォローしている？
  def following?(other_user)
    self.followings.include?(other_user)
  end

  # フォローしているユーザの投稿一覧
  def followings_posts
    Post.where("user_id IN (?)", following_ids)
  end
end
