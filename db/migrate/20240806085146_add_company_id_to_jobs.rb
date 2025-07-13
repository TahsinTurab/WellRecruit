class AddCompanyIdToJobs < ActiveRecord::Migration[7.1]
  def up
    add_reference :jobs, :company, null: false, foreign_key: true
  end

  def down
    remove_reference :jobs, :company
  end
end
