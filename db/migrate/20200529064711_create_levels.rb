class CreateLevels < ActiveRecord::Migration[6.0]
  def change
    create_table :levels do |t|
      t.integer :user_id
      t.date :start_date
      t.integer :level

      t.timestamps
    end
  end
end
