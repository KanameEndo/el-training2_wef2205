require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, user: @user)
    @label = FactoryBot.create(:label)

    visit new_session_path
    fill_in :session_email,with: 'endo00@example.com'
    fill_in :session_password,with: 'endo00'
    click_on'Log in'
  end

  describe 'ラベル管理' do
    context 'ラベルを作成' do
      it "ラベルが作成できる" do
        visit new_label_path
        fill_in 'label[name]', with: '開発'
        click_on '登録する'
        expect(page).to have_content '開発'
      end
    end
    context 'タスクにラベルをつける事ができる' do
      it 'タスク新規作成時にラベルをつける事ができる' do
        visit new_task_path
        fill_in 'task[name]',with: 'test_name'
        fill_in 'task[content]',with: 'test_content'
        fill_in 'task[deadline]' ,with: DateTime.now
        select '未着手', from: "task[status]"
        select '中', from: "task[priority]"
        check "task_label_ids_#{(@label.id)}"
        click_on '登録'
        expect(page).to have_content '開発'
      end
    end
    context 'ラベルで絞り込んで検索した場合' do
      it "ラベルで検索が絞り込まれる" do
        visit tasks_path
        select "開発", from: "task[label_id]"
        click_on 'ラベル選択する'
        expect(page).to have_content '開発'
      end
    end
  end
end
