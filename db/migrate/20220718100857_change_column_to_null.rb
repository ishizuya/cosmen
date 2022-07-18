class ChangeColumnToNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :users, :diagnosis, true
  end

  def down
    change_column_null :users, :diagnosis, false
  end
end
