require 'rails_helper'

describe 'ゲストログイン機能のテスト' do
  describe 'ゲストログイン' do
    before do
      visit root_path
    end
    context 'ゲストログイン表示の確認' do
      it 'トップ画面に「ゲストログイン」リンクが表示されているか' do
        expect(page).to have_link 'ゲストログイン'
      end
      it '「ゲストログイン」リンクが表示される: 4番目ボタンの表示が「ゲストログイン」である' do
        guest_log_in = find_all('a')[4].native.inner_text
        expect(guest_log_in).to match(/ゲストログイン/)
      end
    end
    context 'ログアウト処理のテスト' do
      before do
        guest_login_link = find_all('a')[4]
        guest_login_link.click
      end
      it 'ゲストログイン後のリダイレクト先はTOP画面か' do
        expect(current_path).to eq '/'
      end
      it '「ようこそ、ゲストさん!」と表示されているか' do
        expect(page).to have_content 'ようこそ、ゲストさん!'
      end
    end
  end
end

describe '会員機能' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
      it '「ログイン」リンクが表示される: 3番目ボタンの表示が「ログイン」である' do
        log_in_link = find_all('a')[3].native.inner_text
        expect(log_in_link).to match(/ログイン/)
      end
      it '「ログイン」リンクの内容が正しい' do
        log_in_link = find_all('a')[3].native.inner_text
        expect(page).to have_link log_in_link, href: new_user_session_path
      end
      it '「新規登録」リンクが表示される: 2番目のボタンの表示が「新規登録」である' do
        sign_up_link = find_all('a')[2].native.inner_text
        expect(sign_up_link).to match(/新規登録/)
      end
      it '「新規登録」リンクの内容が正しい' do
        sign_up_link = find_all('a')[2].native.inner_text
        expect(page).to have_link sign_up_link, href: new_user_registration_path
      end
    end
  end
end

describe 'ユーザ新規登録のテスト' do
  before do
    visit new_user_registration_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/user/sign_up'
    end
    it '「新規会員登録」と表示される' do
      expect(page).to have_content '新規会員登録'
    end
    it 'nameフォームが表示される' do
      expect(page).to have_field 'user[name]'
    end
    it 'emailフォームが表示される' do
      expect(page).to have_field 'user[email]'
    end
    it 'ageフォームが表示される' do
      expect(page).to have_select 'user[age]'
    end
    it 'sexフォームが表示される' do
      expect(page).to have_select 'user[sex]'
    end
    it 'skin_typeフォームが表示される' do
      expect(page).to have_select 'user[skin_type]'
    end
    it 'passwordフォームが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it 'password_confirmationフォームが表示される' do
      expect(page).to have_field 'user[password_confirmation]'
    end
    it '「新規会員登録」ボタンが表示される' do
      expect(page).to have_button '新規会員登録'
    end
  end

  context '新規登録成功のテスト' do
    before do
      fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
      fill_in 'user[email]', with: Faker::Internet.email
      select '女性', from: 'user[sex]'
      select '30代', from: 'user[age]'
      select '乾燥', from: 'user[skin_type]'
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
    end

    it '正しく新規登録される' do
      expect { click_button '新規会員登録' }.to change(User.all, :count).by(1)
    end
    it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
      click_button '新規会員登録'
      expect(current_path).to eq '/users/mypage'
    end
  end
end

describe 'ユーザログイン' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
  end

  context '表示内容の確認' do
    it 'URLが正しい' do
      expect(current_path).to eq '/user/sign_in'
    end
    it '「ログイン」と表示される' do
      expect(page).to have_content 'ログイン'
    end
    it 'emailフォームが表示される' do
      expect(page).to have_field 'user[email]'
    end
    it 'passwordフォームが表示される' do
      expect(page).to have_field 'user[password]'
    end
    it '「ログイン」ボタンが表示される' do
      expect(page).to have_button 'ログイン'
    end
  end

  context 'ログイン成功のテスト' do
    before do
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'ログイン'
    end

    it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
      expect(current_path).to eq '/users/mypage'
    end
  end

  context 'ログイン失敗のテスト' do
    before do
      fill_in 'user[email]', with: ''
      fill_in 'user[password]', with: ''
      click_button 'ログイン'
    end

    it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
      expect(current_path).to eq '/user/sign_in'
    end
  end
end

describe 'ヘッダーのテスト: ログインしている場合' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  context 'ヘッダーの表示を確認' do
    it 'Homeリンクが表示される: 左上から1番目のリンクが「マイページ」である' do
      home_link = find_all('a')[1].native.inner_text
      expect(home_link).to match(/マイページ/)
    end
    it 'Usersリンクが表示される: 左上から2番目のリンクが「商品検索」である' do
      users_link = find_all('a')[2].native.inner_text
      expect(users_link).to match(/商品検索/)
    end
    it 'Booksリンクが表示される: 左上から3番目のリンクが「ランキング」である' do
      books_link = find_all('a')[3].native.inner_text
      expect(books_link).to match(/ランキング/)
    end
    it 'Log outリンクが表示される: 左上から4番目のリンクが「化粧品診断」である' do
      logout_link = find_all('a')[4].native.inner_text
      expect(logout_link).to match(/化粧品診断/)
    end
    it 'Log outリンクが表示される: 左上から5番目のリンクが「ログアウト」である' do
      logout_link = find_all('a')[5].native.inner_text
      expect(logout_link).to match(/ログアウト/)
    end
  end
end

describe 'ユーザログアウトのテスト' do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
    logout_link = find_all('a')[5].native.inner_text
    logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
    click_link logout_link
  end

  context 'ログアウト機能のテスト' do
    it '正しくログアウトできている: ログアウト後のリダイレクト先においてログインへのリンクが存在する' do
      expect(page).to have_link 'ログイン'
    end
    it 'ログアウト後のリダイレクト先が、トップになっている' do
      expect(current_path).to eq '/'
    end
  end
end