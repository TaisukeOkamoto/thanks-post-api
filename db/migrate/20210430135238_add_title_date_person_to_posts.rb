class AddTitleDatePersonToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :title, :string
    add_column :posts, :date, :string
    add_column :posts, :person, :string
  end
end
