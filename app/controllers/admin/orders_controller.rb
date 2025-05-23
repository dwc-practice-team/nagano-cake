class Admin::OrdersController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order)
    @total_price = 0
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:notice] = "ステータスを#{@order.status_i18n}に更新しました。"
      if @order.confirm_deposit?
        @order.order_details.each do |order_detail|
          order_detail.update(making_status: "pending_production")
        end
      end
      redirect_to admin_order_path(@order)
    else
      flash[:alert] = "ステータスの更新に失敗しました。"
      render :show
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end
