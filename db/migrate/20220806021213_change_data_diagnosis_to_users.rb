class ChangeDataDiagnosisToUsers < ActiveRecord::Migration[6.1]
  def change
    change_column :users, :diagnosis, :string
  end
end
