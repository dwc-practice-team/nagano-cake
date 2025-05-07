class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  before_action :ensure_cart_items, only: [:new, :confirm, :create]

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

  def create
    @order = current_customer.orders.new(order_params)
    @order.shipping_cost = 800
    @order.total_payment = @order.shipping_cost + @cart_items.sum(&:subtotal)
    if @order.save
      @order.create_order_details(current_customer)
      redirect_to orders_thanks_path
    else
      flash[:alert] = "注文の確定に失敗しました。"
      render :new
    end
  end

  def thanks
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
  end

  private
  
  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :payment_method)
  end

  def ensure_cart_items
    @cart_items = current_customer.cart_items.includes(:item)
    redirect_to items_path unless @cart_items.first
  end
end
