class Admin::OrdersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order)
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "更新しました。"
      redirect_to admin_order_path(@order)
    else
      flash[:alert] = "更新に失敗しました。"
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
