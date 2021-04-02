class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.belongs_to :task
      t.belongs_to :tag

      t.timestamps
    end
  end
end
