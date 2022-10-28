class AddStateToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :state, :string
  end
end
