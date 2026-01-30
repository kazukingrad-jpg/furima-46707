# テーブル設計

## users テーブル

| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| first_name         | string | null: false               |
| last_name          | string | null: false               |
| first_name_kana    | string | null: false               |
| last_name_kana     | string | null: false               |
| birthday           | date   | null: false               |
### Association

- has_many :items
- has_many :orders

## items テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| title                  | string     | null: false                    |
| content                | text       | null: false                    |
| user                   | references | null: false, foreign_key: true |
| category_id            | integer    | null: false                    |
| condition_id           | integer    | null: false                    |
| shipping_fee_burden_id | integer    | null: false                    |
| prefecture_id          | integer    | null: false                    |
| shipping_day_id        | integer    | null: false                    |
| price                  | integer    | null: false                    |


### Association

- belongs_to :user
- has_one    :order

## orders テーブル

| Column    | Type       | Options                                      |
| --------- | ---------- | -------------------------------------------- |
| user      | references | null: false, foreign_key: true               |
| item      | references | null: false, foreign_key: true, unique: true |

### Association

- belongs_to :user
- belongs_to :item
- belongs_to :address

### addresses テーブル

| Column             | Type       | Options                                      |
| ------------------ | ---------- | -------------------------------------------- |
| post_code          | string     | null: false, foreign_key: true               |
| prefecture_id      | integer    | null: false                                  |
| city               | string     | null: false                                  |
| street_address     | string     | null: false                                  |
| building           | string     |                                              |
| phone_number       | integer    | null false                                   |

- has_many :orders
