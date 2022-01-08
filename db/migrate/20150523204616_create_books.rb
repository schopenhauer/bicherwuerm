class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :borrower
      t.text :description
      t.string :location
      t.boolean :loan

      t.integer :publisher_id
      t.integer :language_id
      t.integer :category_id
      t.integer :genre_id
      t.integer :user_id
      t.integer :color_id
      t.integer :collection_id

      t.timestamps null: false
    end
  end
end
