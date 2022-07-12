require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能・管理画面テスト', type: :system do

  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:second_user)
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザ新規登録' do
      it '自分の名前が入ったページへアクセスできる' do
        visit new_user_path
        fill_in 'user[name]', with: 'endo'
        fill_in 'user[email]', with: 'endo@example.com'
        fill_in 'user[password]', with: 'endoendo'
        fill_in 'user[password_confirmation]', with: 'endoendo'
        click_on '登録'
        expect(page).to have_content 'endo@example.com'
      end
    end

    context 'ログインなしでタスク一覧にアクセス' do
      it '​ログインしていない時はログイン画面に飛ぶテスト​' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッションログイン機能テスト' do
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'endo00@example.com'
      fill_in 'session[password]', with:'endo00'
      click_on 'commit'
    end

    context 'ログインした場合' do
      it '自分の詳細画面に飛べること' do
        visit user_path(@user.id)
        expect(current_path).to eq user_path(id: @user.id)
      end

      it "他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
        visit user_path(@second_user.id)
        expect(page).to have_content "タスク一覧"
      end
    end

    context 'ログアウトした場合' do
      it "ログイン画面に戻る" do
        visit user_path(id: @user.id)
        click_on "Logout"
        expect(page).to have_content "ログアウト"
      end
    end
  end

  describe "管理画面のテスト" do
    context "管理ユーザ作成" do
      it "管理者は管理画面にアクセスできること" do
        visit new_session_path
        fill_in "session[email]", with: "endo00@example.com​"
        fill_in "session[password]", with: "endo00"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "ユーザー"
      end
    end

    context "一般ユーザーがログインしている場合" do
      it "一般ユーザーは管理画面にはアクセスできない" do
        visit new_session_path
        fill_in "session[email]", with: "endo26@example.com​"
        fill_in "session[password]", with: "endo26"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "アクセス不可"
      end
    end

    context "管理者でログインしている場合" do
      before do
        visit new_session_path
        fill_in "session[email]", with: "endo00@example.com​"
        fill_in "session[password]", with: "endo00"
        click_on "Log in"
        visit admin_users_path
      end

      it "管理者はユーザ新規登録ができる" do
        click_on "新規ユーザー登録"
        fill_in "user[name]", with: "endo"
        fill_in "user[email]", with: "endo@example.com"
        fill_in "user[password]", with: "endoendo"
        fill_in "user[password_confirmation]", with: "endoendo"
        click_on "登録"
        expect(page).to have_content "endo@example.com"
      end

      it "管理者はユーザの詳細画面へ行ける" do
        visit admin_user_path(@user)
        expect(page).to have_content " endo"
      end

      it "管理者ユーザーの編集画面からユーザーの編集ができる" do
        visit edit_admin_user_path(@user)
        fill_in 'user[name]', with: 'endotest'
        fill_in 'user[email]', with: 'endotest@example.com'
        check 'user[admin]'
        fill_in 'user[password]', with: 'endotest'
        fill_in 'user[password_confirmation]', with: 'endotest'
        click_button '更新'
        expect(page).to have_content "endotest@example.com"
      end

      it'管理者はユーザーの削除ができる' do
        visit admin_users_path
        click_on '削除', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '削除しました'
      end
    end
  end
end
