class Api::V1::RevenueController < ApplicationController
  def top_merchants
    integer_check; return if performed?

    merchants = Merchant.top_merchants_by_revenue(params[:quantity])
    render json: MerchantNameRevenueSerializer.new(merchants)
  end

  private

  def integer_check
    if !params[:quantity].present?
      bad_request(['Quantity query param must exist'])
    elsif params[:quantity].to_i <= 0
      bad_request(['Quantity needs to be an integer greater than 0'])
    end
  end
end
