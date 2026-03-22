class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item

  def index
    @order_address = OrderAddress.new
    gon.payjp_key = ENV['PAYJP_PUBLIC_KEY']
    redirect_to root_path if @item.user_id == current_user.id || @item.order.present?
  end

  def create
    @order_address = OrderAddress.new(order_address_params)
    gon.payjp_key = ENV['PAYJP_PUBLIC_KEY']

    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_address_params
    params.require(:order_address).permit(
      :post_code,
      :prefecture_id,
      :city,
      :street_address,
      :building,
      :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:order_address][:token])
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_address_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end
end