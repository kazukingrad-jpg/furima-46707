FactoryBot.define do
  factory :user do
    sequence(:nickname) { |n| "テスト太郎#{n}" }
    sequence(:email) { |n| "test#{n}@example.com" }
    password { 'aaa111' }
    password_confirmation { 'aaa111' }
    last_name { '山田' }
    first_name { '太郎' }
    last_name_kana { 'ヤマダ' }
    first_name_kana { 'タロウ' }
    birthday { Date.new(1990, 1, 1) }
  end
end