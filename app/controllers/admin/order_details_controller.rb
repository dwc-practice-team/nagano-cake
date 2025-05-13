class Admin::OrderDetailsController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def update
    @order = Order.find(params[:order_id])
    @order_detail = @order.order_details.find(params[:id])
    if @order_detail.update(order_detail_params)
      flash[:notice] = "製作ステータスを#{@order_detail.making_status_i18n}に更新しました。"
      @order.update_status_based_on_details
      redirect_to admin_order_path(@order_detail.order_id)
    else
      flash[:alert] = "製作ステータスの更新に失敗しました。"
      render 'admin/orders/show'
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
