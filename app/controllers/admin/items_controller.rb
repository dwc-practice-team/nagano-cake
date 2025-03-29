class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  def index
    @items = Item.page(params[:page])
  end

  def new
    @item = Item.new
  end

  def show
  end

  def edit
  end
end
