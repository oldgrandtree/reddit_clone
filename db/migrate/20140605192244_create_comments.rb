class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :post_id, null: false
      t.integer :submitter_id, null: false
      t.text :content, null: false
      t.integer :parent_comment_id

      t.timestamps
    end
    
    add_index :comments, :post_id
    add_index :comments, :submitter_id
    add_index :comments, :parent_comment_id
  end
end
