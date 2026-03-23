class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :items, dependent: :destroy
  # Userモデル差分追記
  has_many :orders, dependent: :destroy
 
 
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i
  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_KANA_REGEX = /\A[ァ-ヶー]+\z/

  with_options presence: true do
    validates :nickname
    validates :birthday

    validates :last_name, format: { with: VALID_NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }
    validates :first_name, format: { with: VALID_NAME_REGEX, message: 'は全角（漢字・ひらがな・カタカナ）で入力してください' }

    validates :last_name_kana, format: { with: VALID_KANA_REGEX, message: 'は全角カタカナで入力してください' }
    validates :first_name_kana, format: { with: VALID_KANA_REGEX, message: 'は全角カタカナで入力してください' }
  end

  validates :password, format: { with: VALID_PASSWORD_REGEX, message: 'は英字と数字の両方を含めて設定してください' }, if: :password_required?
end
