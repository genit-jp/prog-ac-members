class Answer < ApplicationRecord
  belongs_to :user
  belongs_to :question
  has_many :code_reviews
  has_rich_text :code
end
