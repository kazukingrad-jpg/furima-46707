class OrderAddress
  include ActiveModel::Model
  attr_accessor :post_code, :prefecture_id, :city, :street_address, :building, :phone_number, :user_id, :item_id, :token

  with_options presence: true do
    validates :post_code, format: { with: /\A\d{3}-\d{4}\z/ }
    validates :city
    validates :street_address
    validates :phone_number, format: { with: /\A\d{10,11}\z/ }
    validates :user_id
    validates :item_id
    validates :token
  end

  validates :prefecture_id, numericality: { other_than: 1 }

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Address.create(
      post_code: post_code,
      prefecture_id: prefecture_id,
      city: city,
      street_address: street_address,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end