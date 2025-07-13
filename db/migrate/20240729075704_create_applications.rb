class CreateApplications < ActiveRecord::Migration[7.1]
  def up
    create_table :applications do |t|
      t.integer :status, default: 0, null: false
      t.references :job, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :applications
  end
end
