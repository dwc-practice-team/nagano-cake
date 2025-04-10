class Public::ItemsController < ApplicationController
  def index
    if params[:search].present?
      @items = Item.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(8)
      @all_items = Item.where('name LIKE ?', "%#{params[:search]}%").all
    else
      @items = Item.page(params[:page]).per(8)
      @all_items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
  end
end
