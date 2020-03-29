json.extract! profile, :id, :user_id, :name, :image, :belong_to, :message, :description, :twitter, :facebook, :web, :github, :place, :created_at, :updated_at
json.url profile_url(profile, format: :json)
