class Api::V1::ItemsController < ApplicationController
  def index
    page = params[:page].to_i.zero? ? 1 : params[:page].to_i
    per_page = params[:per_page].to_i.zero? ? 20 : params[:per_page].to_i
    items = Item.paginate(page: page, per_page: per_page)
    render json: ItemSerializer.new(items)
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def create
    item = Item.create(item_params)
    if item.save
      render json: ItemSerializer.new(item), status: :created
    else
      bad_request(item.errors.full_messages)
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item)
    else
      bad_request(item.errors.full_messages)
    end
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def destroy
    item = Item.find(params[:id])
    item.destroy
    head :no_content
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
