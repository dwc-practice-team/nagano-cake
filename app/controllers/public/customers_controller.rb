class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "変更を保存しました"
      redirect_to my_page_path
    else
      flash.now[:danger] = "変更の保存に失敗しました"
      render :edit
    end
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    current_customer.update_attribute(:is_active, 'false')
    sign_out(current_customer)
    redirect_to new_customer_registration_path, notice: "退会しました"
  end

  private

  def customer_params
    params.require(:customer).permit(
      :last_name,
      :first_name,
      :last_name_kana,
      :first_name_kana,
      :postal_code,
      :address,
      :telephone_number,
      :email
    )
  end
end
