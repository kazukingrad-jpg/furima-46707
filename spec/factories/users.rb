FactoryBot.define do
  factory :user do
    nickname            { "テスト太郎" }
    email               { "test#{rand(10000)}@example.com" }
    password            { "aaa111" }
    password_confirmation { "aaa111" }
    last_name           { "山田" }
    first_name          { "太郎" }
    last_name_kana      { "ヤマダ" }
    first_name_kana     { "タロウ" }
    birthday            { Date.new(1990, 1, 1) }
  end
end
