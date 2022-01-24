class CreateBikes < ActiveRecord::Migration[6.1]
  def change
    create_table :bikes do |t|
      t.boolean :available, default: true
      t.string :description
      t.string :model
      t.integer :price
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
