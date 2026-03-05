class ItemsController < ApplicationController
 before_action :authenticate_user!, only: [:new, :create, :edit, :update]
 before_action :set_item, only: [:show, :edit, :update, :destroy]
 before_action :move_to_root, only: [:edit, :update, :destroy]

  def index
    @items = Item.includes(:order)
                  .with_attached_image
                  .order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def edit
  end

  def destroy
    @item.destroy
    redirect_to items_path
  end

  private

  def item_params
    params.require(:item).permit(
      :title, :content, :price,
      :category_id, :condition_id, :shipping_fee_burden_id, :prefecture_id, :shipping_day_id,
      :image
    ).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_root
    unless @item.user == current_user
      redirect_to root_path
    end
  end

end