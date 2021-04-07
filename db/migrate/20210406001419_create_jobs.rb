class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.integer :job_id
      t.string :title
      t.text :description

      t.timestamps
    end
    add_index :jobs, :job_id
  end
end
