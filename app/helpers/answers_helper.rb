module AnswersHelper
  def self.get_current_question_level(questions, answers)
    ret = 0
    loop = true
    while loop
      ret = ret + 1
      qs = questions.select{|q| q.level == ret and q.availabled}
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

  def self.get_current_level(questions, answers)
    ret = 0
    loop = true
    while loop
      ret = ret + 1
      qs = questions.select{|q| q.level == ret and q.availabled }
      for q in qs do
        as = answers.select{|a|
          a.question_id == q.id and a.code_reviews.select{|c| c.lgtm }.length >= 2
        }
        if as.empty? then
          loop = false
          break
        end
      end
    end
    return ret
  end

  def self.get_reviewers(question)
    users = []
    levels = Level.includes(:user).all
    for level in levels do
      if level.stage > question.stage or
          level.stage >= question.stage and level.level > question.level then
        users.push level.user
      end
    end
    return users.shuffle.slice(0,3)
  end
end
