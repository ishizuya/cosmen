class ChangeColumnNull < ActiveRecord::Migration[6.1]
  def up
    change_column_null :items, :release_date, true
  end

  def down
    change_column_null :items, :release_date, false
  end
end
