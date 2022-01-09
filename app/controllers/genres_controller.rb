class GenresController < ApplicationController
  before_action :set_genre, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @total_book_count = Book.all.size
    @genres = Genre.page(params[:page]).per(APP_CONFIG['max_rows']).order('name ASC')
    if params[:q]
      @genres = @genres.where('(name LIKE ? OR description LIKE ?)', "%#{params[:q]}%", "%#{params[:q]}%")
    end
  end

  def show
  end

  def new
    @genre = Genre.new
  end

  def edit
  end

  def create
    @genre = Genre.new(genre_params)
    respond_to do |format|
      if @genre.save
        format.html { redirect_to edit_genre_path(@genre), notice: 'Genre was successfully created.' }
        format.json { render :show, status: :created, location: @genre }
      else
        format.html { render :new }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @genre.update(genre_params)
        format.html { redirect_to edit_genre_path(@genre), notice: 'Genre was successfully updated.' }
        format.json { render :show, status: :ok, location: @genre }
      else
        format.html { render :edit }
        format.json { render json: @genre.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @genre.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: genres_url, notice: 'Genre was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_genre
    @genre = Genre.find(params[:id])
  end

  def genre_params
    params.require(:genre).permit(:name, :description)
  end
end
