class AddLabelToTaskLabels < ActiveRecord::Migration[6.0]
  def change
    add_reference :task_labels, :label, null: false, foreign_key: true
  end
end
