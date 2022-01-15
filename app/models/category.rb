class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: %i(slugged finders)

  has_many :books

  validates :name, presence: true, uniqueness: true

  before_destroy :reassign_books

  def should_generate_new_friendly_id?
    name_changed?
  end

  private

  def reassign_books
    if name == DEFAULT_CATEGORY[:name]
      false
    else
      Book
        .where(category_id: id)
        .update_all(category_id: default_category) unless books.empty?
    end
  end

  def default_category
    category = Category.find_by(DEFAULT_CATEGORY)
    if category.nil?
      Category.create(DEFAULT_CATEGORY).id
    else
      category.id
    end
  end
end
