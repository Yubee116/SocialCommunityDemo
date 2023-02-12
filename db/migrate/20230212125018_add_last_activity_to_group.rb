class AddLastActivityToGroup < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :last_activity, :timestamp
  end
end
