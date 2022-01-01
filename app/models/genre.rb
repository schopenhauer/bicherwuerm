class Genre < ActiveRecord::Base
  has_many :books

  validates :name, presence: true, uniqueness: true

  after_destroy :reassign_books

  private

  # Make sure each book has a genre
  def reassign_books
    Book
      .where(genre_id: id)
      .update_all(genre_id: default_genre) unless books.empty?
  end

  # Assign DEFAULT_GENRE by default
  def default_genre
    genre = Genre.find_by(DEFAULT_GENRE)
    if genre.nil?
      Genre.create(DEFAULT_GENRE).id
    else
      genre.id
    end
  end
end
