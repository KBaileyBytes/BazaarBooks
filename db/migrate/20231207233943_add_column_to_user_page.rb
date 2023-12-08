class AddColumnToUserPage < ActiveRecord::Migration[7.0]
  def change
    add_column :user_pages, :page_title, :string
  end
end
