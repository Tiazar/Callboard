class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :name
      t.date   :birthday
      t.string :address
      t.string :city
      t.string :state
      t.string :country
      t.integer :zip

      t.timestamps null: false
    end
  end
end
