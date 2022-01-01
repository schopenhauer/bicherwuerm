class Collection < ActiveRecord::Base
  has_many :books

  validates :name, presence: true

  after_destroy :reassign_books

  private

  # Make sure a book's collection_id is removed, when the collection is deleted
  def reassign_books
    Book
      .where(collection_id: id)
      .update_all(collection_id: nil) unless books.empty?
  end
end
