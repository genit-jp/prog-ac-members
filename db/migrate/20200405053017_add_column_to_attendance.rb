class AddColumnToAttendance < ActiveRecord::Migration[5.2]
  def change
    add_column :attendances, :date, :date
    add_column :attendances, :start_time, :string
    add_column :attendances, :end_time, :string
    add_column :attendances, :is_remote, :boolean
  end
end
