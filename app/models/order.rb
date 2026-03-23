class Order < ApplicationRecord
  # Orderモデル差分作成
  belongs_to :user
  belongs_to :item

  has_one :address, dependent: :destroy
end