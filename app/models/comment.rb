class Comment < ActiveRecord::Base
  validates :post_id, :submitter_id, :content, presence: true
  
  belongs_to :post, inverse_of: :comments
  
  belongs_to( 
    :submitter, 
    class_name: "User", 
    foreign_key: :submitter_id, 
    inverse_of: :comments
  )
  
  belongs_to( 
    :parent_comment, 
    class_name: "Comment", 
    foreign_key: :parent_comment_id, 
    inverse_of: :child_comments
  )
  
  has_many( 
    :child_comments, 
    class_name: "Comment", 
    foreign_key: :parent_comment_id,
    inverse_of: :parent_comment
  )
end
