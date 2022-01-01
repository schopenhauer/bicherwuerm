class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    if params[:q]
      @books = Book.search(params[:q])

    else
      if params[:publisher_id]
        @books = Book.where(publisher_id: params[:publisher_id])
        @filter = Publisher.find(params[:publisher_id]).name

      elsif params[:category_id]
        @books = Book.where(category_id: params[:category_id])
        @filter = Category.find(params[:category_id]).name

      elsif params[:language_id]
        @books = Book.where(language_id: Language.friendly.find(params[:language_id]).id)
        @filter = Language.friendly.find(params[:language_id]).name

      elsif params[:genre_id]
        @books = Book.where(genre_id: params[:genre_id])
        @filter = Genre.find(params[:genre_id]).name

      elsif params[:user_id]
        @books = Book.where(user_id: params[:user_id])
        @filter = User.find(params[:user_id]).name

      elsif params[:collection_id]
        @books = Book.where(collection_id: params[:collection_id])
        @filter = Collection.find(params[:collection_id]).name

      elsif params[:color_id]
        @books = Book.where(color_id: Color.friendly.find(params[:color_id]).id)
        @filter = Color.friendly.find(params[:color_id]).name

      else
        @books = Book.all
      end
    end
    @books = @books.includes(:publisher).includes(:user).includes(:category)
                   .includes(:genre).includes(:language).page(params[:page])
                   .per(APP_CONFIG['max_rows'])
  end

  def loans
    @books = index.loans
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

  def remove_amazon_details
    if params[:id]
      flash[:warning] = 'You have removed Amazon-specific information previously associated with this book.'
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
end
