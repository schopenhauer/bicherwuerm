class AddSlugToLanguages < ActiveRecord::Migration[5.0]
  def change
    add_column :languages, :slug, :string
    add_index :languages, :slug, unique: true
  end
end
