class CreateSubmissions < ActiveRecord::Migration[7.1]
  def change
    create_table :submissions do |t|
      t.integer :question_id
      t.references :participation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
