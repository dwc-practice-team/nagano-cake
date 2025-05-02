class Admin::HomesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def top
    @orders = Order.includes(:order_details).order(created_at: :desc).page(params[:page])
  end
end
