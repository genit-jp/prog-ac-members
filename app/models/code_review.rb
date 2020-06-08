class CodeReview < ApplicationRecord
  belongs_to :answer
  belongs_to :user
  has_rich_text :comment
end
