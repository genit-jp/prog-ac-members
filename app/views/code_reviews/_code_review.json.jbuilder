json.extract! code_review, :id, :user_id, :answer_id, :lgtm, :created_at, :updated_at
json.url code_review_url(code_review, format: :json)
