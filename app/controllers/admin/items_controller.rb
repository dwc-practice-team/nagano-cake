class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'

  def index
    if params[:search].present?
      @items = Item.where('name LIKE ?', "%#{params[:search]}%").page(params[:page]).per(10)
    else
      @items = Item.page(params[:page]).per(10)
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "新規登録が完了しました"
      redirect_to admin_item_path(@item)
    else
      flash.now[:danger] = "新規登録に失敗しました"
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "更新を保存しました"
      redirect_to admin_item_path(@item)
    else
      flash.now[:danger] = "更新の保存に失敗しました"
      render :edit
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :genre_id, :price, :is_active)
  end
end
