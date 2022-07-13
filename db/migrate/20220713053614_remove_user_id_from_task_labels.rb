class RemoveUserIdFromTaskLabels < ActiveRecord::Migration[6.0]
  def change
    remove_column :task_labels, :user_id, :bigint
  end
end
