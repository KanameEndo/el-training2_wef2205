require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      before do
        visit new_task_path
        fill_in 'task_name', with: 'task.name'
        fill_in 'task_content', with: 'task.content'
        fill_in 'DateTime', with: 'DateTime'
        click_button '新規登録'
      end

      it '正常に登録される' do
        expect(page).to have_content 'task'
      end
    end
    context 'タスクを新規登録するとき終了期限も登録できる'
      it '終了期限のタスクが一番上に表示される'
        task_list = all('.task_row')
      end
  end

  describe '一覧表示機能' do
    context '一覧画面にアクセスしたとき' do
      before do
        visit tasks_path
      end

      it '作成済みのタスクが表示されている' do
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('.task_row')
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task, name: 'name', content: 'content')
        visit task_path(@task.id)
      end
    end
  end
end

