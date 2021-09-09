# frozen_string_literal: true

module Api
  module V1
    class RevenueController < ApplicationController
      def top_merchants
        integer_check; return if performed?

        merchants = Merchant.top_merchants_by_revenue(params[:quantity])
        render json: MerchantNameRevenueSerializer.new(merchants)
      end

      def merchant
        merchant = Merchant.find(params[:id])
        render json: MerchantRevenueSerializer.new(merchant)
      rescue ActiveRecord::RecordNotFound
        not_found
      end

      def top_items
        if params[:quantity].present? && params[:quantity].to_i <= 0
          bad_request(['Quantity needs to be an integer greater than 0'])
        else
          limit = params[:quantity].to_i.zero? ? 10 : params[:quantity].to_i
          items = Item.top_items_by_revenue(limit)
          render json: ItemRevenueSerializer.new(items)
        end
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
  end
end
