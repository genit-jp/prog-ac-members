json.extract! attendance, :id, :user_id, :starts_at, :ends_at, :created_at, :updated_at
json.url attendance_url(attendance, format: :json)
