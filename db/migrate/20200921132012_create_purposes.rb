class CreatePurposes < ActiveRecord::Migration[6.0]
  def change
    create_table :purposes do |t|
      t.integer :user_id
      t.string :title
      t.string :text
      t.string :result

      t.timestamps
    end
  end
end
