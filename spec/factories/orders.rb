FactoryBot.define do
  factory :order do
    association :user, strategy: :create
    association :item, strategy: :create
  end
end