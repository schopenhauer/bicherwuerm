class CreateIdeas < ActiveRecord::Migration[5.0]
  def change
    create_table :ideas do |t|
      t.string :title
      t.string :author
      t.string :description
      t.integer :user_id

      t.timestamps
    end
    add_index :ideas, :user_id
  end
end
