class Api::V1::MerchantsController < ApplicationController
  def index
    page = params[:page].to_i.zero? ? 1 : params[:page].to_i
    per_page = params[:per_page].to_i.zero? ? 20 : params[:per_page].to_i
    merchants = Merchant.paginate(page: page, per_page: per_page)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = Merchant.find(params[:id])
    render json: MerchantSerializer.new(merchant)
  rescue ActiveRecord::RecordNotFound
    not_found
  end
end
