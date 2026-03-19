class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :move_to_index

  def index
    gon.payjp_key = ENV["PAYJP_PUBLIC_KEY"]
  end

  def create
    @order = Order.new(user_id: current_user.id, item_id: @item.id)
    @address = Address.new(address_params)

    if @order.valid? && @address.valid?
      pay_item
      @order.save
      @address.order_id = @order.id
      @address.save
      redirect_to root_path
    else
      gon.payjp_key = ENV["PAYJP_PUBLIC_KEY"]
      render :index, status: :unprocessable_entity
    end
  end

  private

  def address_params
    params.require(:order).permit(
      :post_code, :prefecture_id, :city, :street_address, :building, :phone_number
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    redirect_to root_path if @item.user_id == current_user.id || @item.order.present?
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: params[:token],
      currency: 'jpy'
    )
  end
end