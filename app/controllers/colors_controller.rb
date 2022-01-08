class ColorsController < ApplicationController
  before_action :set_color, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @total_book_count = Book.all.size
    @colors = Color.page(params[:page]).per(APP_CONFIG['max_rows']).order('name ASC')
    if params[:q]
      @colors = @colors.where('(name LIKE ? OR description LIKE ?)', "%#{params[:q]}%", "%#{params[:q]}%")
    end
  end

  def show
  end

  def new
    @color = Color.new
  end

  def edit
  end

  def create
    @color = Color.new(color_params)

    respond_to do |format|
      if @color.save
        format.html { redirect_to edit_color_path(@color), notice: 'Color was successfully created.' }
        format.json { render :show, status: :created, location: @color }
      else
        format.html { render :new }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @color.update(color_params)
        format.html { redirect_to edit_color_path(@color), notice: 'Color was successfully updated.' }
        format.json { render :show, status: :ok, location: @color }
      else
        format.html { render :edit }
        format.json { render json: @color.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @color.destroy
    respond_to do |format|
      format.html { redirect_to edit_color_path(@color), notice: 'Color was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_color
    @color = Color.find(params[:id])
  end

  def color_params
    params.require(:color).permit(:name, :description, :hex_code)
  end
end
