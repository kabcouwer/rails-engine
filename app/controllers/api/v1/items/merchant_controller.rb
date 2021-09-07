module Api
  module V1
    module Items
      class MerchantController < ApplicationController
        def index
          merchant_id = Item.find(params[:item_id]).merchant_id
          merchant = Merchant.find(merchant_id)
          render json: MerchantSerializer.new(merchant)
        rescue ActiveRecord::RecordNotFound
          not_found
        end
      end
    end
  end
end
