class CreateDailyReports < ActiveRecord::Migration[6.0]
  def change
    create_table :daily_reports, id: :string do |t|
      t.string :slack_user_id
      t.string :text
      t.datetime :ts
      t.string :team

      t.timestamps
    end
  end
end
