class AnswersController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, except:  [:slack]

  def index
    @user_id = params[:user_id] || current_user.id
    @answers = Answer.includes(:code_reviews).where(:user_id => @user_id)
    @questions = Question.where(:availabled => true).order(:level).order(:index).with_rich_text_question_and_embeds
    raise "Invalid Error"
  end
  def new
    @answer = Answer.find_or_initialize_by(:user_id => current_user.id, :question_id => params[:question_id])
    @question = Question.find(@answer.question_id)
  end
  def edit
    @answer = Answer.find(params[:id])
    @question = Question.find(@answer.question_id)
  end
  def show
    @answer = Answer.includes(:code_reviews).find(params[:id])
    @question = Question.find(@answer.question_id)
  end
  def create
    super
    post_slack(@answer)
  end
  private

    def answer_params
      params.require(:answer).permit(:user_id, :question_id, :code)
    end

  def post_slack(answer)
    client = Slack::Web::Client.new({token: Rails.application.credentials.slack[:bot_token]})
    name = answer.user.profile.name
    title = answer.question.title
    url = answer_url(answer)
    users = AnswersHelper.get_reviewers(answer.question)
    mention = ''
    logger.debug users
    for user in users do
      slack_user_id = user.profile.slack_user_id
      if slack_user_id then
        mention += "<@#{slack_user_id}>"
      end
    end

    message = "#{mention}\nレビューお願いします「#{title}」by #{name}\n#{url}"
    logger.debug message
    client.chat_postMessage(channel: Rails.application.credentials.slack[:code_review_channel], text: message)
  end

end
