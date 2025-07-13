class CreateResponses < ActiveRecord::Migration[7.1]
  def change
    create_table :responses do |t|
      t.integer :answer_id
      t.boolean :correct
      t.references :submission, null: false, foreign_key: true

      t.timestamps
    end
  end
end
