class CreateLanguages < ActiveRecord::Migration[5.0]
  def change
    create_table :languages do |t|
      t.string :name
      t.string :local
      t.string :acronym

      t.timestamps null: false
    end
  end
end
