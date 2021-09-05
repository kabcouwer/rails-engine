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
  end

  def create
    render json: Item.create(item_params)
  end

  def destroy
    render json: Item.delete(params[:id])
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
