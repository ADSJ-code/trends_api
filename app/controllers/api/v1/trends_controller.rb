module Api
  module V1
    class TrendsController < ApplicationController
      def index
        @products = Product.all
        render json: @products
      end
    end
  end
end