class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.integer :position
      t.belongs_to :user

      t.timestamps
    end
  end
end
