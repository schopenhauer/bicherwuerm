class CollectionsController < ApplicationController
  before_action :set_collection, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @total_book_count = Book.all.size
    @collections = Collection.page(params[:page]).per(APP_CONFIG['max_rows']).order('name ASC')
    if params[:q]
      @collections = @collections.where('(name LIKE ? OR description LIKE ?)', "%#{params[:q]}%", "%#{params[:q]}%")
    end
  end

  def show
  end

  def new
    @collection = Collection.new
  end

  def edit
  end

  def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to edit_collection_path(@collection), notice: 'Collection was successfully created.' }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to edit_collection_path(@collection), notice: 'Collection was successfully updated.' }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_back fallback_location: collections_url, notice: 'Collection was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_collection
    @collection = Collection.find(params[:id])
  end

  def collection_params
    params.require(:collection).permit(:name, :description)
  end
end
