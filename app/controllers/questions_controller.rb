class QuestionsController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, :require_admin, except: [:api_post]
  protect_from_forgery except: [:api_post]

  def api_post
    @question = Question.find_or_initialize_by(:stage => params[:stage].to_i, :level => params[:level].to_i, :index => params[:index].to_i)
    @question.title = params[:title]
    @question.availabled = true
    @question.question = params[:question].gsub(/\R/, '<br/>')
    @question.save
    render json: {message: 'ok'}, :status => 200

  end

  private

    def question_params
      params.require(:question).permit(:stage, :level, :index, :title, :question, :link, :availabled)
    end

end
