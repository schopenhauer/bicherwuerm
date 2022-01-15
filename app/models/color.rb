class Color < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: %i(slugged finders)

  has_many :books

  validates :name, presence: true
  validates :hex_code, presence: false, format: {
    with: %r{^#(([0-9a-fA-F]{2}){3}|([0-9a-fA-F]){3})$},
    multiline: true
  }

  after_destroy :reassign_books
  before_save :downcase_hex_code

  def should_generate_new_friendly_id?
    name_changed?
  end

  private

  def reassign_books
    Book
      .where(color_id: id)
      .update_all(color_id: nil) unless books.empty?
  end

  def downcase_hex_code
    hex_code.downcase!
  end
end
