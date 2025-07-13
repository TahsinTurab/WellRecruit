class CreateCompanies < ActiveRecord::Migration[7.1]
  def up
    create_table :companies do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :category
      t.text :description
      t.text :address
      t.string :phone
      t.string :registration_number, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :companies, :name, unique: true
    add_index :companies, :email, unique: true
  end

  def down
    drop_table :companies
  end
end
