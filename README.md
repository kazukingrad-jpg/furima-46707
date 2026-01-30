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
| birth_year         | integer| null: false               |
| birth_month        | integer| null: false               |
| birth_date         | integer| null: false               |

### Association

- has_many :items
- has_many :orders

## items テーブル

| Column                 | Type       | Options                        |
| ---------------------- | ---------- | ------------------------------ |
| title                  | string     | null: false                    |
| content                | text       | null: false                    |
| user                   | references | null: false, foreign_key: true |
| category               | integer    | null: false                    |
| condition              | integer    | null: false                    |
| shipping_fee_burden    | integer    | null: false                    |
| prefecture             | integer    | null: false                    |
| shipping_day           | integer    | null: false                    |
| price                  | integer    | null: false                    |


### Association

- belongs_to :users
- has_one    :orders

## orders テーブル

| Column    | Type       | Options                                      |
| --------- | ---------- | -------------------------------------------- |
| user      | references | null: false, foreign_key: true               |
| item      | references | null: false, foreign_key: true, unique: true |

### Association

- belongs_to :user
- belongs_to :items

