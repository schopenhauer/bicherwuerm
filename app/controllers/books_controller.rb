class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if params[:q]
      books = Book
        .joins(:publisher)
        .joins(:genre)
        .joins(:category)
        .joins(:language)
        .where('books.title LIKE ? OR books.author LIKE ? OR books.location LIKE ? OR books.borrower LIKE ? OR publishers.name LIKE ? OR genres.name LIKE ? OR categories.name LIKE ?',
               "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    else
      if params[:publisher_id]
        books = Book.where(publisher_id: params[:publisher_id])
        filter = Publisher.find(params[:publisher_id])
      elsif params[:category_id]
        books = Book.where(category_id: Category.find(params[:category_id]))
        filter = Category.find(params[:category_id])
      elsif params[:language_id]
        books = Book.where(language_id: Language.find(params[:language_id]))
        filter = Language.find(params[:language_id])
      elsif params[:genre_id]
        books = Book.where(genre_id: params[:genre_id])
        filter = Genre.find(params[:genre_id])
      elsif params[:user_id]
        books = Book.where(user_id: params[:user_id])
        filter = User.find(params[:user_id])
      elsif params[:collection_id]
        books = Book.where(collection_id: params[:collection_id])
        filter = Collection.find(params[:collection_id])
      elsif params[:color_id]
        books = Book.where(color_id: Color.find(params[:color_id]))
        filter = Color.find(params[:color_id])
      else
        books = Book.all
      end
    end
    @filter = filter&.name
    @books = paginate(books.order(APP_CONFIG['book_order']))
  end

  def outstanding_loans
    @books = paginate(Book.loans.order(updated_at: :desc))
  end

  def recently_created
    @books = paginate(Book.order(created_at: :desc))
  end

  def recently_updated
    @books = paginate(Book.order(updated_at: :desc))
  end

  def show
  end

  def new
    @book = Book.new
  end

  def edit
  end

  def create
    @book = Book.new(book_params)
    respond_to do |format|
      if @book.save
        format.html { redirect_to edit_book_path(@book), notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to edit_book_path(@book), notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: books_url, notice: 'Book was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  # TODO: move to AmazonController?
  def remove_amazon_details
    if params[:id]
      flash[:warning] = 'You have removed all Amazon-specific information associated with this book.'
      Book.update(
        params[:id],
        amazon_title: nil,
        amazon_author: nil,
        amazon_asin: nil,
        amazon_isbn: nil,
        amazon_publisher: nil,
        amazon_url: nil,
        amazon_image_url: nil,
        amazon_updated_at: nil,
        amazon_info: false
      )
      redirect_back fallback_location: { action: 'edit', id: params[:id] }
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :author, :publisher_id, :category_id, :genre_id, :language_id, :user_id, :collection_id, :color_id, :borrower, :loan, :location, :description)
  end

  def paginate(books)
    books.page(params[:page]).per(APP_CONFIG['max_rows'])
  end

end
