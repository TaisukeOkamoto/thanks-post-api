class AddTitleDatePersonToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :date, :string
    add_column :users, :person, :string
    add_column :users, :title, :string
  end
end
