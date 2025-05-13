class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!

  def index
    @cart_items = current_customer.cart_items.includes(:item)
    @total_price = 0
  end

  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
    if @cart_item
      @cart_item.amount += params[:cart_item][:amount].to_i
    else
      @cart_item = current_customer.cart_items.new(cart_item_params)
    end
    if @cart_item.save
      flash[:notice] = "カートに商品を追加しました"
      redirect_to cart_items_path
    else
      flash.now[:danger] = "カートへの商品追加に失敗しました"
      render 'items/show'
    end
  end

  def update
    @cart_item = CartItem.find_by(id: params[:id], customer_id: current_customer.id)
    @cart_item.update(cart_item_params)
    flash[:notice] = "カート内情報を更新しました。"
    redirect_to cart_items_path
  end

  def destroy
    cart_item = CartItem.find(params[:id])
    cart_item.destroy
    flash[:notice] = "削除しました"
    redirect_to cart_items_path
  end

  def destroy_all
    cart_items = CartItem.where(customer_id: current_customer.id)
    cart_items.destroy_all
    flash[:notice] = "削除しました"
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
