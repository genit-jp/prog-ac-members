class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.string :name_kana
      t.string :icon_image
      t.string :pr_sheet_image
      t.string :title
      t.string :goal
      t.string :message
      t.string :description

      t.timestamps
    end
  end
end
