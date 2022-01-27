class AddDeclinedToRentals < ActiveRecord::Migration[6.1]
  def change
    add_column :rentals, :declined, :boolean, default: false
    add_column :rentals, :declined_comment, :text
    add_column :rentals, :completed, :boolean, default: false
  end
end
