class AddCompanyToUsers < ActiveRecord::Migration[7.1]
  def up
    add_reference :users, :office, foreign_key: { to_table: :companies }, null: true
  end

  def down
    remove_reference :users, :office
  end
end
