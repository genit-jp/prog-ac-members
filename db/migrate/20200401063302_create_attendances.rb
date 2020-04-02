class CreateAttendances < ActiveRecord::Migration[5.2]
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.datetime :starts_at
      t.datetime :ends_at

      t.timestamps
    end
  end
end
