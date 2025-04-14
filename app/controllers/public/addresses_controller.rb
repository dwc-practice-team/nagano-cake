class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!
  before_action :is_matching_login_customer, only: [:edit, :update, :destroy]
  def index
    @address = Address.new
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def create
    @address = current_customer.addresses.build(address_params)
    @addresses = Address.where(customer_id: current_customer.id)
    if @address.save
      flash[:notice] = "登録しました"
      redirect_to addresses_path
    else
      flash.now[:danger] = "登録に失敗しました"
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = "変更を保存しました"
      redirect_to addresses_path
    else
      flash.now[:danger] = "変更の保存に失敗しました"
      render :edit
    end
  end

  def destroy
    address = Address.find(params[:id])
    address.destroy
    flash[:notice] = "削除しました"
    redirect_to addresses_path
  end

  private

  def is_matching_login_customer
    address = Address.find(params[:id])
    unless address.customer_id == current_customer.id
      redirect_to addresses_path
    end
  end

  def address_params
    params.require(:address).permit(:postal_code, :address, :name)
  end
end
