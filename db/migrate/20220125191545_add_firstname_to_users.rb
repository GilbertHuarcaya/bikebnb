class AddFirstnameToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :phone_number, :string
    add_column :users, :city, :string
  end
end
