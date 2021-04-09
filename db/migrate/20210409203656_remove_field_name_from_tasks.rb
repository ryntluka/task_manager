class RemoveFieldNameFromTasks < ActiveRecord::Migration[6.1]
  def change
    remove_column :tasks, :attachment, :string
  end
end
