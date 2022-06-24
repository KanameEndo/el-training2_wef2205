require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      before do
        visit new_task_path
        fill_in 'task_name', with: 'task.name'
        fill_in 'task_content', with: 'task.content'
        click_button 'Create Task'
      end

      it '正常に登録される' do
        expect(page).to have_content 'task'
      end
    end
  end

  describe '一覧表示' do
    context '一覧画面にアクセスしたとき' do
      before do
        visit tasks_path
      end

      it '作成済みのタスクが表示されている' do
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      before do
        visit tasks_path
      end
      it '該当タスクの内容が表示される' do
    end
  end
end
end
