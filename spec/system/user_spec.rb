require 'rails_helper'
RSpec.describe 'ユーザ登録・ログイン・ログアウト機能・管理画面テスト', type: :system do

  before do
    @user = FactoryBot.create(:user)
    @second_user = FactoryBot.create(:second_user)
  end

  describe 'ユーザ登録のテスト' do
    context 'ユーザ新規登録' do
      it '自身の名が入ったページへアクセスできる' do
        visit new_user_path
        fill_in 'user[name]', with: 'name_endo'
        fill_in 'user[email]', with: 'endo@example.com'
        fill_in 'user[password]', with: 'endoendo'
        fill_in 'user[password_digest]', with: 'endoendo'
        click_on 'アカウントを登録する'
        expect(page).to have_content 'endo'
      end
    end

    context 'ログインなしでタスク一覧にアクセス' do
      it '​ログインしていない時はログイン画面に飛ぶテスト​' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end

  describe 'セッション機能テスト' do
    before do
      visit new_session_path
      fill_in 'session[email]', with: 'endo@example.com'
      fill_in 'session[password]', with:'endoendo'
      click_on 'commit'
    end

    context 'ログインした場合' do
      it '自分の詳細画面に飛べること' do
        expect(current_path).to eq user_path(@user.id)
        expect(page).to have_content 'endo'
      end

      it "他人の詳細画面に飛ぶとタスク一覧ページに遷移すること" do
        visit user_path(@second_user.id)
        expect(page).to have_content "タスク一覧"
      end
    end

    context 'ログアウトした場合' do
      it "ログイン画面に戻る" do
        visit user_path(id: @user.id)
        click_link "ログアウト"
        expect(page).to have_content "ログイン"
      end
    end
  end

  describe "管理画面のテスト" do
    context "管理ユーザ作成" do
      it "管理者は管理画面にアクセスできること" do
        visit new_session_path
        fill_in "session[email]", with: "endo@example.com​"
        fill_in "session[password]", with: "endo"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "ユーザー一覧"
      end
    end

    context "一般ユーザーがログインしている場合" do
      it "一般ユーザーは管理画面にはアクセスできない" do
        visit new_session_path
        fill_in "session[email]", with: "endo@example.com​"
        fill_in "session[password]", with: "endo"
        click_on "Log in"
        visit admin_users_path
        expect(page).to have_content "管理者以外は"
      end
    end

    context "管理者でログインしている場合" do
      before do
        visit new_session_path
        fill_in "session[email]", with: "endo@example.com​"
        fill_in "session[password]", with: "endo"
        click_on "Log in"
        visit admin_users_path
      end

      it "管理者はユーザ新規登録ができる" do
        click_link "新規ユーザー作成"
        fill_in "user[name]", with: "Taro Endo"
        fill_in "user[email]", with: "endo@example.com"
        fill_in "user[password]", with: "endo"
        fill_in "user[password_confirmation]", with: "endo"
        click_on "登録する"
        expect(page).to have_content "endo"
      end

      it "管理者はユーザの詳細画面へ行ける" do
        visit admin_user_path(@user)
        expect(page).to have_content " endo"
      end

      it "管理者ユーザーの編集画面からユーザーの編集ができる" do
        visit edit_admin_user_path(@user)
        fill_in 'user[name]', with: 'endo11'
        fill_in 'user[email]', with: 'endo11@example.com'
        check 'user[admin]'
        fill_in 'user[password]', with: 'endo'
        fill_in 'user[password_confirmation]', with: 'endo'
        click_button '登録する'
        expect(page).to have_content "endo11"
      end

      it "管理者はユーザーを削除できる" do
        visit admin_users_path
        click_link "Delete", match: :first
      end
    end
  end
end
