module AnswersHelper
  def self.get_current_level(questions, answers)
    ret = 0
    loop = true
    while loop
      ret = ret + 1
      qs = questions.select{|q| q.level == ret}
      for q in qs do
        as = answers.select{|a| a.question_id == q.id}
        if as.empty? then
          loop = false
          break
        end
      end
    end
    return ret
  end
end
