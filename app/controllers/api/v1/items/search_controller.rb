module Api
  module V1
    module Items
      class SearchController < ApplicationController
        def find_all
          check_search_params; return if performed?

          if params[:name].present?
            items = Item.name_search(params[:name])
            render json: ItemSerializer.new(items) and return
          end

          if params[:min_price].present? || params[:max_price].present?
            items = Item.price_search(params[:min_price], params[:max_price])
            render json: ItemSerializer.new(items) and return
          end
          bad_request(['Name query or Min/max price query must exist'])
        end

        private

        def check_search_params
          if params[:name].present? && (params[:min_price].present? || params[:max_price].present?)
            bad_request(['Name OR either/both price parameters may be sent'])
          end
        end
      end
    end
  end
end
