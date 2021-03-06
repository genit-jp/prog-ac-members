class BookingsController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, except: [:slack]
  protect_from_forgery except: [:slack]

  def create
    booking = Booking.find_or_initialize_by(:date => Date.parse(params[:date]), :start_time => params[:start_time])
    notice = '予約を受け付けました'
    if booking.user_id then
      notice = '既に予約が入っています'
    else
      booking.user_id = current_user.id
      booking.title = params[:title]
      booking.save
      client = Slack::Web::Client.new({token: Rails.application.credentials.slack[:bot_token]})
      client.chat_postMessage(channel: Rails.application.credentials.slack[:one_on_one_channel], text: "新規登録：#{current_user.profile.name}：#{booking.date}/#{booking.start_time}〜")
    end
    redirect_to attendances_path(:date => params[:date]), notice: notice
  end

  def slack
    now = Time.current
    bookings = Booking.where("date = ? AND (start_time = ? OR start_time = ?)", Date.current, "#{now.hour+1}:00", "#{now.hour+1}:30")
    client = Slack::Web::Client.new({token: Rails.application.credentials.slack[:bot_token]})
    logger.debug bookings.length
    for booking in bookings do
      message = "#{booking.user.profile.name}さん\n#{booking.date}/#{booking.start_time}〜 1on1の予定が入っています"
      client.chat_postMessage(channel: Rails.application.credentials.slack[:one_on_one_channel], text: message)
      client.chat_postMessage(channel: Rails.application.credentials.slack[:admin_user_channel], text: message)
      slack_user_id = booking.user.profile.slack_user_id
      if slack_user_id.present?
        client.chat_postMessage(channel: slack_user_id, text: message)
      end
    end
    render json: { message: 'ok' }, :status => 200
  end

  private

    def booking_params
      params.require(:booking).permit(:user_id, :date, :start_time, :title)
    end

    def post_slack(message, channel)
      render :text => 'ok', :status => 200

    end

end
