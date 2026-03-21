require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    order = FactoryBot.create(:order)
    @address = FactoryBot.build(:address, order: order)
  end

  describe '配送先情報の保存' do
    context '保存できる場合' do
      it '全ての値が正しく入力されていれば保存できる' do
        expect(@address).to be_valid
      end

      it 'buildingは空でも保存できる' do
        @address.building = ''
        expect(@address).to be_valid
      end
    end

    context '保存できない場合' do
      it 'post_codeが空では保存できない' do
        @address.post_code = ''
        @address.valid?
        expect(@address.errors[:post_code]).to include("can't be blank")
      end

      it 'post_codeがハイフンなしでは保存できない' do
        @address.post_code = '1234567'
        @address.valid?
        expect(@address.errors[:post_code]).to include('is invalid')
      end

      it 'prefecture_idが1では保存できない' do
        @address.prefecture_id = 1
        @address.valid?
        expect(@address.errors[:prefecture_id]).to include('must be other than 1')
      end

      it 'cityが空では保存できない' do
        @address.city = ''
        @address.valid?
        expect(@address.errors[:city]).to include("can't be blank")
      end

      it 'street_addressが空では保存できない' do
        @address.street_address = ''
        @address.valid?
        expect(@address.errors[:street_address]).to include("can't be blank")
      end

      it 'phone_numberが空では保存できない' do
        @address.phone_number = ''
        @address.valid?
        expect(@address.errors[:phone_number]).to include("can't be blank")
      end

      it 'phone_numberが9桁以下では保存できない' do
        @address.phone_number = '123456789'
        @address.valid?
        expect(@address.errors[:phone_number]).to include('is invalid')
      end

      it 'phone_numberが12桁以上では保存できない' do
        @address.phone_number = '123456789012'
        @address.valid?
        expect(@address.errors[:phone_number]).to include('is invalid')
      end

      it 'phone_numberにハイフンが含まれていると保存できない' do
        @address.phone_number = '090-1234-5678'
        @address.valid?
        expect(@address.errors[:phone_number]).to include('is invalid')
      end
    end
  end
end