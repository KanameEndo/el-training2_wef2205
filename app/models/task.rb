class Task < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30}
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status:{ 未着手: 0, 進行中: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }

  scope :name_search, -> (task_name) {where('(name LIKE ?)',"%#{params[:task][:name]}%")}
  scope :status_search, -> (task_status){where(status: params[:status][:status])}
end
