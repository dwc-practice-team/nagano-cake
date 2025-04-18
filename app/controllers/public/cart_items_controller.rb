class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  def index
  end

  def create
    @cart_item = current_customer.cart_items.build(cart_item_params)
    if @cart_item.save
      flash[:notice] = "カートに商品を追加しました"
      redirect_to cart_items_path
    else
      flash.now[:danger] = "カートへの商品追加に失敗しました"
      render 'items#show'
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
