class Book < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :language
  belongs_to :category
  belongs_to :genre
  belongs_to :user
  
  belongs_to :collection, optional: true
  belongs_to :color, optional: true

  validates :title, presence: true
  validates :author, presence: true
  validates :publisher, presence: true
  validates :category, presence: true
  validates :genre, presence: true
  validates :language, presence: true
  validates :user, presence: true

  before_save :update_loan_flag
  before_save :sanitize_strings

  default_scope { order(APP_CONFIG['book_order']) }

  scope :loans, -> { where(loan: true) }
  scope :amazon_info, -> { where(amazon_info: true, amazon_skipped: false) }
  scope :no_amazon_info, -> { where(amazon_info: false, amazon_skipped: false) }

  rating

  private

  def update_loan_flag
    self.loan = !borrower.blank?
    true
  end

  def sanitize_strings
    title.tr!('´', '\'')
    author.tr!('´', '\'')
  end

  class << self
    def search(query)
      joins(:publisher)
        .joins(:category)
        .joins(:genre)
        .joins(:language)
        .where('books.title LIKE ? OR books.author LIKE ? OR books.location LIKE ? OR books.borrower LIKE ? OR publishers.name LIKE ? OR genres.name LIKE ? OR categories.name LIKE ?',
               "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
    end
  end
end
