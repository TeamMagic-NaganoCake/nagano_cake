class Public::CustomersController < ApplicationController




  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customers_params)
      redirect_to customers_my_page_path, notice: "会員情報が更新されました。"
    else
      render :edit
    end
  end

  def confirm
  end

  def withdraw
  end

  private

  def customers_params
    params.require(:customer).permit(
      :last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :address, :phone_number, :email
    )
  end


end
