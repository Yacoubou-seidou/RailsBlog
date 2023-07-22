class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.integer :author_id
      t.index :author_id
      t.foreign_key :users, column: :author_id

      t.string :title
      t.text :text
      t.integer :comments_counter, default: 0 # Set default value to 0
      t.timestamps
      t.integer :likes_counter, default: 0 # Set default value to 0
    end
  end
end
