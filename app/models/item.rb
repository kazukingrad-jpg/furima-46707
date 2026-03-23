class Item < ApplicationRecord
  belongs_to :user
  has_one :order

  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee_burden
  belongs_to :prefecture
  belongs_to :shipping_day

  with_options presence: true do
    validates :image
    validates :title
    validates :content
    validates :price
  end

  with_options numericality: { other_than: 1, message: "を選択してください" } do
    validates :category_id
    validates :condition_id
    validates :shipping_fee_burden_id
    validates :prefecture_id
    validates :shipping_day_id
  end

  validates :price,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 300,
              less_than_or_equal_to: 9_999_999,
              message: "は300〜9,999,999の間で入力してください"
            }

  def sold_out?
    order.present?
  end
end