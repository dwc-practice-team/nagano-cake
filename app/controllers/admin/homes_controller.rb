class Admin::HomesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def top
    if params[:customer_id].present?
      @customer = Customer.find_by(id: params[:customer_id])
      @orders = Order.where(customer_id: params[:customer_id]).includes(:order_details).order(created_at: :desc).page(params[:page])
    else
      @orders = Order.includes(:order_details).order(created_at: :desc).page(params[:page])
    end
  end
end
