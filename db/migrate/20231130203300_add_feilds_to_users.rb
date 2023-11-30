class AddFeildsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :users, :province, null: false, foreign_key: true
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :is_admin, :boolean
    add_column :users, :address, :string
    add_column :users, :phone, :string
    add_column :users, :postal_code, :string
  end
end
