class RenameUidColumnToUsers < ActiveRecord::Migration[6.1]
  def change
    rename_column :users, :uid, :sub
  end
end
