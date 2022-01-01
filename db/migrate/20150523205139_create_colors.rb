class CreateColors < ActiveRecord::Migration[5.0]
  def change
    create_table :colors do |t|
      t.string :name
      t.string :description
      t.string :hex_code

      t.timestamps
    end
  end
end
