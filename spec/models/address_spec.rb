require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @address = FactoryBot.build(:address)
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
        expect(@address.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post_codeがハイフンなしでは保存できない' do
        @address.post_code = '1234567'
        @address.valid?
        expect(@address.errors.full_messages).to include('Post code is invalid')
      end

      it 'prefecture_idが1では保存できない' do
        @address.prefecture_id = 1
        @address.valid?
        expect(@address.errors.full_messages).to include('Prefecture must be other than 1')
      end

      it 'cityが空では保存できない' do
        @address.city = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("City can't be blank")
      end

      it 'street_addressが空では保存できない' do
        @address.street_address = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Street address can't be blank")
      end

      it 'phone_numberが空では保存できない' do
        @address.phone_number = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが9桁以下では保存できない' do
        @address.phone_number = '123456789'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is invalid')
      end

      it 'phone_numberが12桁以上では保存できない' do
        @address.phone_number = '123456789012'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is invalid')
      end

      it 'phone_numberにハイフンが含まれていると保存できない' do
        @address.phone_number = '090-1234-5678'
        @address.valid?
        expect(@address.errors.full_messages).to include('Phone number is invalid')
      end
    end
  end
end