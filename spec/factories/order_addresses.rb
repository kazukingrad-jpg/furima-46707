FactoryBot.define do
  factory :order_address do
    post_code { '123-4567' }
    prefecture_id { 2 }
    city { '横浜市' }
    street_address { '青山1-1-1' }
    building { '柳ビル103' }
    phone_number { '09012345678' }
    token { 'tok_abcdefghijk00000000000000000' }

    user_id { FactoryBot.create(:user).id }
    item_id { FactoryBot.create(:item).id }
  end
end