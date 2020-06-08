class Question < ApplicationRecord
  has_many :answers
  has_rich_text :question
  def question_str

    CGI.escape(self.question.to_s)
  end
end
