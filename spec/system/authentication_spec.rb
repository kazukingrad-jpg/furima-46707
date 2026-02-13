require 'rails_helper'

RSpec.describe 'Authentication', type: :system do
  before do
    driven_by(:rack_test)
  end

  it '未ログイン時、ログイン/新規登録リンクが表示される' do
    visit root_path
    expect(page).to have_link('ログイン', href: new_user_session_path)
    expect(page).to have_link('新規登録', href: new_user_registration_path)
  end

  it '新規登録後、自動ログイン状態でトップへ遷移し、ニックネーム/ログアウトが表示される' do
    visit new_user_registration_path

    fill_in 'nickname', with: 'aaa'
    fill_in 'email', with: 'aaa@example.com'
    fill_in 'password', with: 'aaa111'
    fill_in 'password-confirmation', with: 'aaa111'
    fill_in 'last-name', with: '山田'
    fill_in 'first-name', with: '太郎'
    fill_in 'last-name-kana', with: 'ヤマダ'
    fill_in 'first-name-kana', with: 'タロウ'

    select '1995', from: 'user_birthday_1i'
    select '1', from: 'user_birthday_2i'
    select '1', from: 'user_birthday_3i'

    click_button '会員登録'

    if current_path == new_user_registration_path
      puts page.body
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content('aaa')
    expect(page).to have_link('ログアウト')
  end

 it '空欄があると登録できず、エラーメッセージが表示される' do
  visit new_user_registration_path

  fill_in 'nickname', with: 'aaa'
  fill_in 'email', with: ''
  fill_in 'password', with: 'aaa111'
  fill_in 'password-confirmation', with: 'aaa111'
  fill_in 'last-name', with: '山田'
  fill_in 'first-name', with: '太郎'
  fill_in 'last-name-kana', with: 'ヤマダ'
  fill_in 'first-name-kana', with: 'タロウ'
  select '1995', from: 'user_birthday_1i'
  select '1', from: 'user_birthday_2i'
  select '1', from: 'user_birthday_3i'

  expect do
    click_button '会員登録'
  end.not_to change(User, :count)

  expect(current_path).to eq(user_registration_path)

  expect(page).to have_content("can't be blank").or have_content('を入力してください')
  end



  it 'ログインでき、トップへ遷移してログアウトが表示される' do
    user = User.create!(
      nickname: 'taro',
      email: 'taro@example.com',
      password: 'aaa111',
      password_confirmation: 'aaa111',
      last_name: '山田',
      first_name: '太郎',
      last_name_kana: 'ヤマダ',
      first_name_kana: 'タロウ',
      birthday: Date.new(1995, 1, 1)
    )

    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'aaa111'
    click_button 'ログイン'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('taro')
    expect(page).to have_link('ログアウト')
  end

  it 'ログアウトでき、ログイン/新規登録が表示される' do
    user = User.create!(
      nickname: 'taro',
      email: 'taro2@example.com',
      password: 'aaa111',
      password_confirmation: 'aaa111',
      last_name: '山田',
      first_name: '太郎',
      last_name_kana: 'ヤマダ',
      first_name_kana: 'タロウ',
      birthday: Date.new(1995, 1, 1)
    )

    visit new_user_session_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'aaa111'
    click_button 'ログイン'

    click_link 'ログアウト'

    expect(current_path).to eq(root_path)
    expect(page).to have_link('ログイン', href: new_user_session_path)
    expect(page).to have_link('新規登録', href: new_user_registration_path)
  end
end
