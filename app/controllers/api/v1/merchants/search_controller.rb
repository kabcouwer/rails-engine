module Api
  module V1
    module Merchants
      class SearchController < ApplicationController
        def find
          if params[:name].present?
            if (merchant = Merchant.name_search(params[:name]).first)
              render json: MerchantSerializer.new(merchant)
            else
              render json: { data: {} }, status: :ok
            end
          else
            bad_request(['Name query must exist'])
          end
        end
      end
    end
  end
end
