FactoryBot.define do
  factory :item do
    title { "テスト商品" }
    content { "商品の説明テキスト" }

    category_id { 2 }
    condition_id { 2 }
    shipping_fee_burden_id { 2 }
    prefecture_id { 2 }
    shipping_day_id { 2 }

    price { 3000 }
    association :user

    after(:build) do |item|
      item.image.attach(
        io: File.open(Rails.root.join("spec/fixtures/files/test_image.png")),
        filename: "test_image.png",
        content_type: "image/png"
      )
    end
  end
end