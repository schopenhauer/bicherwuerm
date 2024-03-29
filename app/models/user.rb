class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :books
  has_many :ideas

  before_save :downcase_email
  after_destroy :reassign_books

  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true,
            length: { maximum: 255 },
            format: { with: %r{\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z} },
            uniqueness: { case_sensitive: false }

  private

  def downcase_email
    email.downcase
  end

  def reassign_books
    Book
      .where(user_id: id)
      .update_all(user_id: default_user) unless books.empty?
  end

  def default_user
    user = User.find_by(DEFAULT_USER)
    if user.nil?
      User.create(DEFAULT_USER).id
    else
      user.id
    end
  end
end
