class Sub < ActiveRecord::Base
  validates :title, :description, :moderator, presence: true
  validates :title, uniqueness: true
  
  belongs_to(
    :moderator, 
    class_name: "User", 
    foreign_key: :moderator_id, 
    inverse_of: :subs
  )
  has_many :posts, inverse_of: :sub
end
