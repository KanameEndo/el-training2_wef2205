class Task < ApplicationRecord
  belongs_to :user

  validates :name, presence: true, length: { maximum: 30}
  validates :content, presence: true
  validates :deadline, presence: true
  validates :status, presence: true
  validates :priority, presence: true

  enum status:{ 未着手: 0, 進行中: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }

  scope :search_name, -> (name) {where("name LIKE ?", "%#{name}%")}
  scope :search_status, -> (status) {where(status: status)}

  paginates_per 5
end
