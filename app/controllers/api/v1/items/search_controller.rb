module Api
  module V1
    module Items
      class SearchController < ApplicationController
        def find_all
          if params[:name].present?
            items = Item.search(params[:name])
            render json: ItemSerializer.new(items)
          else
            not_found
          end
        end
      end
    end
  end
end
