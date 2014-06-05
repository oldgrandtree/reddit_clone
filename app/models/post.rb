class Post < ActiveRecord::Base
  
  validates :title, :sub, :submitter, presence: true
  validates :title, :uniqueness => { scope: :url }
  
  belongs_to :sub, inverse_of: :posts
  
  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    inverse_of: :posts
  )
  
  has_many :comments, inverse_of: :post
end
