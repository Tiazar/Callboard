class User < ActiveRecord::Base
  before_save { self.email = email.downcase }
  validates :login, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, 
  			format: { with: VALID_EMAIL_REGEX },
  			uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, length: { minimum: 6 }
  validates :name, presence: true, length: { maximum: 200}
  validates_date :birthday, presence: true
  validates :address, presence: true
  validates :city, presence: true, length: { maximum: 100}
  validates :state, presence: true
  validates :country, presence: true
  validates :zip, presence: true, length: { maximum: 6}
end