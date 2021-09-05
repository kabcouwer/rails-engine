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
end
