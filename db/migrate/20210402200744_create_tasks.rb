class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.boolean :id_done
      t.string :attachment
      t.belongs_to :user
      t.belongs_to :project

      t.timestamps
    end
  end
end
