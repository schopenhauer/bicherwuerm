class AddAmazonToBooks < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :amazon_title, :string
    add_column :books, :amazon_author, :string
    add_column :books, :amazon_asin, :string
    add_column :books, :amazon_isbn, :string
    add_column :books, :amazon_publisher, :string
    add_column :books, :amazon_url, :string
    add_column :books, :amazon_image_url, :string
    add_column :books, :amazon_updated_at, :datetime, null: true
    add_column :books, :amazon_info, :boolean, default: false
    add_column :books, :amazon_skipped, :boolean, default: false
  end
end
