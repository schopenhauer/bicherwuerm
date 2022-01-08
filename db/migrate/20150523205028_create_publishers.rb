class CreatePublishers < ActiveRecord::Migration[7.0]
  def change
    create_table :publishers do |t|
      t.string :name
      t.string :website
      t.text :description

      t.timestamps null: false
    end
  end
end
