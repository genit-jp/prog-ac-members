class AddColumnToPurpose < ActiveRecord::Migration[6.0]
  def change
    add_column :purposes, :goal6m, :string
    add_column :purposes, :goal3m, :string
    add_column :purposes, :goal1m, :string
  end
end
