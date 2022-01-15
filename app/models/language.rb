class Language < ActiveRecord::Base
  extend FriendlyId
  friendly_id :acronym, use: :slugged

  has_many :books

  validates :name, presence: true
  validates :local, presence: true
  validates :acronym, presence: true, uniqueness: true

  after_destroy :reassign_books

  def should_generate_new_friendly_id?
    name_changed?
  end

  private

  def reassign_books
    Book
      .where(language_id: id)
      .update_all(language_id: default_language) unless books.empty?
  end

  def default_language
    language = Language.find_by(DEFAULT_LANGUAGE)
    if language.nil?
      Language.create(DEFAULT_LANGUAGE).id
    else
      language.id
    end
  end
end
