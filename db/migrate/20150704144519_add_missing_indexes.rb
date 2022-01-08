class AddMissingIndexes < ActiveRecord::Migration[5.0]
  def change
    add_index :books, :publisher_id
    add_index :books, :language_id
    add_index :books, :category_id
    add_index :books, :collection_id
    add_index :books, :genre_id
    add_index :books, :user_id
    add_index :books, :color_id
  end
end
