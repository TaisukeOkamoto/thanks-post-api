class AddUidProfileTextIsConfirmedToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :uid, :string
    add_column :users, :profile_text, :string
    add_column :users, :is_confirmed, :boolean
  end
end
