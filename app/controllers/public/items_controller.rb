class Public::ItemsController < ApplicationController
  def index
    @genres = Genre.all
    if params[:search].present?
      @all_items = Item.where('name LIKE ?', "%#{params[:search]}%")
      @items = @all_items.page(params[:page]).per(8)
    elsif params[:genre_name].present?
      @genre = Genre.find_by(name: params[:genre_name])
      @all_items = Item.where(genre_id: @genre&.id)
      @items = @all_items.page(params[:page]).per(8)
    else
      @items = Item.page(params[:page]).per(8)
      @all_items = Item.all
    end
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end
end
