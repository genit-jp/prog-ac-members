class QuestionsController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, :require_admin, except: [:api_post]
  protect_from_forgery except: [:api_post]

  def index
    @questions = Question.all.order(:stage).order(:level).order(:index)
  end

  def api_post
    @questions = Question.all
    for question in questions do
      question.level = question.level + 1
      question.save
    end
    render json: {message: 'ok'}, :status => 200
  end

  private

    def question_params
      params.require(:question).permit(:stage, :level, :index, :title, :question, :link, :availabled)
    end

end
