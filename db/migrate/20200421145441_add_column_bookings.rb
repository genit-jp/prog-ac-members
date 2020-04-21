class AddColumnBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :title, :string
  end
end
