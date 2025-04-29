class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    if params[:select_address] == '0'
      @order.get_shipping_infomation_from(current_customer)
    elsif params[:select_address] == '1'
      @selected_address = current_customer.addresses.find(params[:address_id])
      @order.get_shipping_infomation_from(@selected_address)
    elsif params[:select_address] == '2' && (@order.postal_code =~ /\A\d{7}\z/) && @order.address? && @order.name?
      # 処理なし(新規住所入力のため)
    else
      flash[:alert] = "情報を正しく入力してください。"
      render :new
    end
  end

  def thanks
  end

  def index
  end

  def show
  end

  private
  
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end
end
