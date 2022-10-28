class AddTransitionsToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :transitions, :text, array: true, default: []
  end
end
