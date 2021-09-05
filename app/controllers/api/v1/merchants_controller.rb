class Api::V1::MerchantsController < ApplicationController
  def index
    @page = params[:page]
    @per_page = params[:per_page]
    @merchants = Merchant.paginate(page: @page, per_page: @per_page)
    render json: MerchantSerializer.new(@merchants)
  end
end
