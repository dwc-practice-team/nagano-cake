class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
    @addresses = current_customer.addresses.all
  end

  def thanks
  end

  def index
  end

  def show
  end
end
