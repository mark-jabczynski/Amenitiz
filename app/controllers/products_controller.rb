# frozen_string_literal: true

class ProductsController < ApplicationController
  def index
    @products = ::Queries::Product.all
  end

  def show
    @product = ::Queries::Product.by_code(params[:code]).take!
  end
end
