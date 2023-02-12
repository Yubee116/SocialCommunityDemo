class AddLastActivityToPost < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :last_activity, :timestamp
  end
end
