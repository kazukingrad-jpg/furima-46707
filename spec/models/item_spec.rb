require "rails_helper"

RSpec.describe Item, type: :model do
  let(:item) { FactoryBot.build(:item) }

  describe "商品出品（Item）" do
    context "出品できる場合" do
      it "必要な情報が全てあれば保存できる" do
        expect(item).to be_valid
      end
    end

    context "出品できない場合" do
      it "imageが空だと保存できない" do
        item.image = nil
        item.valid?
        expect(item.errors.full_messages).to include("Image can't be blank")
      end

      it "titleが空だと保存できない" do
        item.title = ""
        item.valid?
        expect(item.errors.full_messages).to include("Title can't be blank")
      end

      it "contentが空だと保存できない" do
        item.content = ""
        item.valid?
        expect(item.errors.full_messages).to include("Content can't be blank")
      end

      it "category_idが1（---）だと保存できない" do
        item.category_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Category を選択してください")
      end

      it "condition_idが1（---）だと保存できない" do
        item.condition_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Condition を選択してください")
      end

      it "shipping_fee_burden_idが1（---）だと保存できない" do
        item.shipping_fee_burden_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Shipping fee burden を選択してください")
      end

      it "prefecture_idが1（---）だと保存できない" do
        item.prefecture_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Prefecture を選択してください")
      end

      it "shipping_day_idが1（---）だと保存できない" do
        item.shipping_day_id = 1
        item.valid?
        expect(item.errors.full_messages).to include("Shipping day を選択してください")
      end

      it "priceが空だと保存できない" do
        item.price = nil
        item.valid?
        expect(item.errors.full_messages).to include("Price can't be blank")
      end

      it "priceが299以下だと保存できない" do
        item.price = 299
        item.valid?
        expect(item.errors.full_messages).to include("Price は300〜9,999,999の間で入力してください")
      end

      it "priceが10,000,000以上だと保存できない" do
        item.price = 10_000_000
        item.valid?
        expect(item.errors.full_messages).to include("Price は300〜9,999,999の間で入力してください")
      end

      it "priceが全角数字だと保存できない" do
        item.price = "３００"
        item.valid?
        expect(item.errors.full_messages).to include("Price は300〜9,999,999の間で入力してください")
      end

      it "priceが英字混在だと保存できない" do
        item.price = "300a"
        item.valid?
        expect(item.errors.full_messages).to include("Price は300〜9,999,999の間で入力してください")
      end

      it "userが紐付いていないと保存できない" do
        item.user = nil
        item.valid?
        expect(item.errors.full_messages).to include("User must exist")
      end
    end
  end
end