# frozen_string_literal: true

require 'rails_helper'

describe 'BI - Items by Revenue API' do
  before :each do
    revenue_factories
  end

  describe 'happy paths' do
    it 'returns items ranked by revenue' do
      limit = 20

      get "/api/v1/revenue/items?quantity=#{limit}"
    end
  end

  describe 'sad paths' do
    it '' do

    end
  end
end
