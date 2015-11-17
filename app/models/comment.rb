class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :user_id, presence: true
  default_scope -> { order('created_at ASC') }
  validates :content, presence: true, length: { maximum: 900 }
end
