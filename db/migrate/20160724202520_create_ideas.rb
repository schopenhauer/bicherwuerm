class CreateIdeas < ActiveRecord::Migration[7.0]
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
