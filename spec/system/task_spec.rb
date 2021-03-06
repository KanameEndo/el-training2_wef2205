require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @task = FactoryBot.create(:task, user: @user)
    #アソシエーションが組まれる↑

    visit new_session_path
    fill_in :session_email,with: 'endo00@example.com'
    fill_in :session_password,with: 'endo00'
    click_on'Log in'
  end

  describe '検索機能' do
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in 'task[name]', with: 'task'
        click_on '検索'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        select "完了", from: "task[status]"
        click_on '検索'
        expect(page).to have_content '完了'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in 'task[name]', with: 'task'
        select "完了", from: "task[status]"
        click_on '検索'
        expect(page).to have_content 'task'
        expect(page).to have_content '完了'
      end
    end
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[name]',with: 'test_name'
        fill_in 'task[content]',with: 'test_content'
        fill_in 'task[deadline]' ,with: DateTime.now
        select '未着手', from: "task[status]"
        select '中', from: "task[priority]"
        click_on '登録'
        expect(page).to have_content 'タスクを登録しました'
        expect(page).to have_content '未着手'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        task_list= all('.task_list')
        expect(page).to have_content 'task'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, name: 'task', user: @user)
        FactoryBot.create(:second_task, name: 'task2', user: @user)
        FactoryBot.create(:third_task, name: 'task3', user: @user)
        visit tasks_path
        task_list= all('.task_list')
        save_and_open_page
        expect(task_list[2]).to have_content 'task'
        expect(task_list[1]).to have_content 'task2'
        expect(task_list[0]).to have_content 'task3'
      end
    end

    context '終了期限でソートした場合' do
      it 'タスクが終了期限順に並んでいる' do
        FactoryBot.create(:task, name: 'task', user: @user)
        FactoryBot.create(:second_task, name: 'task2', user: @user)
        FactoryBot.create(:third_task, name: 'task3', user: @user)
        visit tasks_path
        click_on '終了期限' 
        visit tasks_path(sort_expired: "true")
        task_list = all('.task_list')
        expect(task_list[2]).to have_content 'task'
        expect(task_list[1]).to have_content 'task2'
        expect(task_list[0]).to have_content 'task3'
      end
    end

    context '優先度高い順でソートした場合' do
      it '優先度高い順で並んでいる' do
        FactoryBot.create(:second_task, name: 'task2', user: @user)
        FactoryBot.create(:third_task, name: 'task3', user: @user)
        visit tasks_path
        click_on '優先度'
        tasks_path(sort_priority_high: "true")
        sleep 1
        task_list = all('.task_list')
        expect(task_list[2]).to have_content 'task'
        expect(task_list[1]).to have_content 'task2'
        expect(task_list[0]).to have_content 'task3'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, name: 'task', user: @user)
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
      task = FactoryBot.create(:task, name: 'task', content: 'task', user: @user)
      visit task_path(task.id)
      expect(page).to have_content 'task'
      end
    end
  end
end
