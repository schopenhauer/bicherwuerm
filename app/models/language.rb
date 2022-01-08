class Language < ActiveRecord::Base
  extend FriendlyId
  friendly_id :acronym, use: [:slugged, :finders]

  has_many :books

  validates :name, presence: true
  validates :local, presence: true
  validates :acronym, presence: true, uniqueness: true

  after_destroy :reassign_books

  # will change the slug if the name changed
  def should_generate_new_friendly_id?
    name_changed?
  end

  private

  # Make sure each book has a language
  def reassign_books
    Book
      .where(language_id: id)
      .update_all(language_id: default_language) unless books.empty?
  end

  # Assign DEFAULT_LANGUAGE by default
  def default_language
    language = Language.find_by(DEFAULT_LANGUAGE)
    if language.nil?
      Language.create(DEFAULT_LANGUAGE).id
    else
      language.id
    end
  end
end
