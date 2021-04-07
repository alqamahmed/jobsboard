class CreateApplications < ActiveRecord::Migration[6.1]
  def change
    create_table :applications do |t|
      t.integer :app_id
      t.integer :user_id
      t.integer :job_id
      t.boolean :seen

      t.timestamps
    end
    add_index :applications, :app_id
  end
end
