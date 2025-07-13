class CreateAssessments < ActiveRecord::Migration[7.1]
  def change
    create_table :assessments do |t|
      t.string :title
      t.datetime :starting_time
      t.datetime :ending_time
      t.integer :candidate_selection
      t.references :job, null: false, foreign_key: true

      t.timestamps
    end
  end
end
