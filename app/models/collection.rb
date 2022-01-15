class Collection < ActiveRecord::Base
  has_many :books

  validates :name, presence: true

  after_destroy :reassign_books

  private

  def reassign_books
    Book
      .where(collection_id: id)
      .update_all(collection_id: nil) unless books.empty?
  end
end
