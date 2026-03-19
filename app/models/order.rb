class Order < ApplicationRecord
  attr_accessor :token
  belongs_to :user
  belongs_to :item

  has_one :address, dependent: :destroy

  validates :user_id, presence: true
  validates :item_id, presence: true

end