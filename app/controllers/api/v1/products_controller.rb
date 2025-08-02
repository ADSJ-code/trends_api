class Api::V1::ProductsController < ApplicationController
  # GET /api/v1/products
  def index
    @products = Product.all
    render json: @products
  end
end