module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def find
          if params[:name].present?
            if (merchant = Merchant.search(params[:name]).first)
              render json: MerchantSerializer.new(merchant)
            else
              render json: { data: {} }, status: :ok
            end
          else
            not_found
          end
        end
      end
    end
  end
end
