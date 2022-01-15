class Genre < ActiveRecord::Base
  has_many :books

  validates :name, presence: true, uniqueness: true

  after_destroy :reassign_books

  private

  def reassign_books
    Book
      .where(genre_id: id)
      .update_all(genre_id: default_genre) unless books.empty?
  end

  def default_genre
    genre = Genre.find_by(DEFAULT_GENRE)
    if genre.nil?
      Genre.create(DEFAULT_GENRE).id
    else
      genre.id
    end
  end
end
