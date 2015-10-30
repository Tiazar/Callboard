class Post < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  default_scope -> { order('created_at DESC') }
  validates :content, presence: true, length: { maximum: 1800 }
end
