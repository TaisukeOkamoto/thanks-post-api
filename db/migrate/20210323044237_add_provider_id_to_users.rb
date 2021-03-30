class AddProviderIdToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :provider_id, :string
  end
end
