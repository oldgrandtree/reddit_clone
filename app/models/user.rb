class User < ActiveRecord::Base
  
  before_validation :ensure_token
  validates :username, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :token, presence: true, uniqueness: true
  validates :password, length: { minimum: 6, allow_nil: true }
  
  has_many :subs, foreign_key: :moderator_id, inverse_of: :moderator
  has_many :posts, foreign_key: :submitter_id, inverse_of: :submitter
  has_many( 
    :comments,  
    foreign_key: :submitter_id, 
    inverse_of: :submitter
  )
  
  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
  
  def self.find_by_credentials(username, password)
    user = User.find_by_username(username)
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end
  
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def password
    @password
  end
  
  def reset_token!
    self.token = generate_token
    self.save!
    self.token
  end
  
  private
  
  def generate_token
    SecureRandom.urlsafe_base64(16)
  end
  
  def ensure_token
    self.token ||= generate_token
  end
end
