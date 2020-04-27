json.extract! article, :id, :title, :description, :priority, :is_active, :created_at, :updated_at
json.url article_url(article, format: :json)
