# frozen_string_literal: true

class OrdersController < ApplicationController
  def index
    @orders = ::Queries::Order.all
  end

  def show
    @products = Queries::Product.by_code(order.basket.keys).all
  end

  def add_product
    @order = Orders::AddProduct::EntryPoint.new(**order_params).call

    redirect_to order_path(order.uuid, product_code: params[:product_code])
  end

  private

  def order
    @order ||= Queries::Order.by_uuid(params[:uuid]).take
  end

  def order_params
    {
      order_uuid: params[:uuid],
      product_code: params[:product_code]
    }.tap do |params|
      params[:quantity] = params[:quantity].to_i if params[:quantity].present?
    end
  end
end
