class ChangeSeenColumn < ActiveRecord::Migration[6.1]
  def change
  	change_column :applications, :seen, :boolean, default: false
  end
end
