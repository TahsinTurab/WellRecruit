class CreateJobs < ActiveRecord::Migration[7.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.text :overview
      t.text :responsibilities
      t.text :requirements
      t.text :benifits
      t.string :location
      t.datetime :deadline
      t.string :salary_range
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
