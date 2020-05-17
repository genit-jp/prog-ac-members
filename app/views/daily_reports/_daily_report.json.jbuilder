json.extract! daily_report, :id, :id, :user_id, :text, :ts, :slack_user_id, :team, :created_at, :updated_at
json.url daily_report_url(daily_report, format: :json)
