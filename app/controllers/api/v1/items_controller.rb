class Api::V1::ItemsController < ApplicationController
  def index
    page = params[:page]
    per_page = params[:per_page]
    @items = Item.paginate(page: page, per_page: per_page)
    render json: ItemSerializer.new(@items)
  end

  def show
    @item = Item.find(params[:id])
    render json: ItemSerializer.new(@item)
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      render json: ItemSerializer.new(@item), status: :created
    else
      render json: { errors: @item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
