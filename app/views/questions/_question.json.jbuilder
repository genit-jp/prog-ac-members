json.extract! question, :id, :stage, :level, :title, :text, :created_at, :updated_at
json.url question_url(question, format: :json)
