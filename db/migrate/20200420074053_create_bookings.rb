class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.integer :user_id
      t.date :date
      t.string :start_time

      t.timestamps
    end
  end
end
