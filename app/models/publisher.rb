class Publisher < ActiveRecord::Base
  has_many :books

  validates :name, presence: true, uniqueness: true

  after_destroy :reassign_books

  private

  def reassign_books
    Book
      .where(publisher_id: id)
      .update_all(publisher_id: default_publisher) unless books.empty?
  end

  def default_publisher
    publisher = Publisher.find_by(DEFAULT_PUBLISHER)
    if publisher.nil?
      Publisher.create(DEFAULT_PUBLISHER).id
    else
      publisher.id
    end
  end
end
