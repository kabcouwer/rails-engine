class Api::V1::Merchants::ItemsController < ApplicationController
  def index
    items = Merchant.find(params[:merchant_id]).items
    render json: ItemSerializer.new(items)
  rescue ActiveRecord::RecordNotFound
    not_found
  end
end