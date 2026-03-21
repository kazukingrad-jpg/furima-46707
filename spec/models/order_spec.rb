require 'rails_helper'

RSpec.describe Order, type: :model do
  before do
    @order = FactoryBot.build(:order)
  end

  describe '購入情報の保存' do
    context '保存できる場合' do
      it 'userとitemが存在すれば保存できる' do
        expect(@order).to be_valid
      end
    end

    context '保存できない場合' do
      it 'userが紐づいていないと保存できない' do
        @order.user = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('User must exist')
      end

      it 'itemが紐づいていないと保存できない' do
        @order.item = nil
        @order.valid?
        expect(@order.errors.full_messages).to include('Item must exist')
      end
    end
  end
end