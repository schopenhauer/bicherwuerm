class Category < ActiveRecord::Base
  has_many :books

  validates :name, presence: true, uniqueness: true

  before_destroy :reassign_books

  private

  # Make sure each book has a category
  def reassign_books
    if name == DEFAULT_CATEGORY[:name]
      false
    else
      Book
        .where(category_id: id)
        .update_all(category_id: default_category) unless books.empty?
    end
  end

  # Assign DEFAULT_CATEGORY by default
  def default_category
    category = Category.find_by(DEFAULT_CATEGORY)
    if category.nil?
      Category.create(DEFAULT_CATEGORY).id
    else
      category.id
    end
  end
end
