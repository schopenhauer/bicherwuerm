class LanguagesController < ApplicationController
  before_action :set_language, only: [:edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @total_book_count = Book.all.size
    @languages = Language.page(params[:page]).per(APP_CONFIG['max_rows']).order('name ASC')
    if params[:q]
      @languages = @languages.where('(name LIKE ? OR locale LIKE ? OR acronym LIKE ?)', "%#{params[:q]}%", "%#{params[:q]}%", "%#{params[:q]}%")
    end
  end

  def new
    @language = Language.new
  end

  def edit
  end

  def create
    @language = Language.new(language_params)

    respond_to do |format|
      if @language.save
        format.html { redirect_to edit_language_path(@language), notice: 'Language was successfully created.' }
        format.json { render :show, status: :created, location: @language }
      else
        format.html { render :new }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @language.update(language_params)
        format.html { redirect_to edit_language_path(@language), notice: 'Language was successfully updated.' }
        format.json { render :show, status: :ok, location: @language }
      else
        format.html { render :edit }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @language.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: languages_url, notice: 'Language was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_language
    @language = Language.find(params[:id])
  end

  def language_params
    params.require(:language).permit(:name, :local, :acronym)
  end
end
