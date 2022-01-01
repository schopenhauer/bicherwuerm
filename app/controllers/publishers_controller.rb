class PublishersController < ApplicationController
  before_action :set_publisher, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @total_book_count = Book.all.size
    @publishers = Publisher.page(params[:page]).per(APP_CONFIG['max_rows']).order('name ASC')
    if params[:q]
      @publishers = @publishers.where('(name LIKE ? OR description LIKE ?)', "%#{params[:q]}%", "%#{params[:q]}%")
    end
  end

  def show
  end

  def new
    @publisher = Publisher.new
  end

  def edit
  end

  def create
    @publisher = Publisher.new(publisher_params)
    respond_to do |format|
      if @publisher.save
        format.html { redirect_to edit_publisher_path(@publisher), notice: 'Publisher was successfully created.' }
        format.json { render :show, status: :created, location: @publisher }
      else
        format.html { render :new }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @publisher.update(publisher_params)
        format.html { redirect_to edit_publisher_path(@publisher), notice: 'Publisher was successfully updated.' }
        format.json { render :show, status: :ok, location: @publisher }
      else
        format.html { render :edit }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @publisher.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: publishers_url, notice: 'Publisher was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_publisher
    @publisher = Publisher.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def publisher_params
    params.require(:publisher).permit(:name, :website, :description)
  end
end
