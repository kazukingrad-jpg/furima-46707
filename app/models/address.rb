class Address < ApplicationRecord
  belongs_to :order

  with_options presence: true do
    validates :post_code
    validates :prefecture_id
    validates :city
    validates :street_address
    validates :phone_number
  end

  validates :post_code, format: { with: /\A\d{3}-\d{4}\z/ }
  validates :prefecture_id, numericality: { other_than: 1 }
  validates :phone_number, format: { with: /\A\d{10,11}\z/ }
end