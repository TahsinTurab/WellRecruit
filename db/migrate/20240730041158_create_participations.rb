class CreateParticipations < ActiveRecord::Migration[7.1]
  def change
    create_table :participations do |t|
      t.integer :score
      t.references :application, null: false, foreign_key: true
      t.references :assessment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
