class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :comments, dependent: :destroy
  has_many :posts, dependent: :destroy
  before_save { self.email = email.downcase }
  before_create :create_remember_token
  validates :login, presence: true, length: { maximum: 50 }, uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true,
  			format: { with: VALID_EMAIL_REGEX },
  			uniqueness: { case_sensitive: false }
  validates :name, presence: true, length: { maximum: 200}
  validates_date :birthday, presence: true
  validates :address, presence: true
  validates :city, presence: true, length: { maximum: 100}
  validates :state, presence: true
  validates :country, presence: true
  validates :zip, presence: true, length: { maximum: 6}
  geocoded_by :address
  after_validation :geocode

  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end

    def fulladdress
      [address, city, state, country].compact.join(', ')
    end
end
