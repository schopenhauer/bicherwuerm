class Color < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: [:slugged, :finders]

  has_many :books

  validates :name, presence: true
  validates :hex_code, presence: false, format: {
    with: VALID_COLOR,
    multiline: true
  }

  after_destroy :reassign_books
  before_save :downcase_hex_code

  # will change the slug if the name changed
  def should_generate_new_friendly_id?
    name_changed?
  end

  private

  # Make sure book's color_id gets removed, if color deleted
  def reassign_books
    Book
      .where(color_id: id)
      .update_all(color_id: nil) unless books.empty?
  end

  def downcase_hex_code
    hex_code.downcase!
  end
end
