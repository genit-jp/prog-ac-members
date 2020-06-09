class LevelsController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, :require_admin, except: [:check]
  protect_from_forgery except: [:check]

  def new
    @level = Level.find_or_initialize_by(:user_id => params[:user_id])
  end

  def check
    users = User.includes(:level).includes(answers:[:code_reviews]).includes(:profile).where(:is_active => true)
    questions = Question.all
    for user in users do
      if user.level.stage == 1 then
        level = AnswersHelper.get_current_level(questions, user.answers)
        if user.level.level < level then
          user.level.level = level
          post_slack("<@#{user.profile.slack_user_id}>さんのレベルが*#{user.level.to_s}*にアップしました！")
          user.level.save
        end
      end
    end
    render :plain => 'ok', :status => 200
  end

  private
  def post_slack(message)
    client = Slack::Web::Client.new({token: Rails.application.credentials.slack[:bot_token]})
    client.chat_postMessage(channel: Rails.application.credentials.slack[:level_up_channel], text: message)
  end

    def level_params
      params.require(:level).permit(:user_id, :start_date, :level, :stage)
    end

end
