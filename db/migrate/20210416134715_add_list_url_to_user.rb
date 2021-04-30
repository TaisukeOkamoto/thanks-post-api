class AddListUrlToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :list_url, :string
  end
end
