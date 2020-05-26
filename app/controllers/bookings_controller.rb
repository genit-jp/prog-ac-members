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
      client = Slack::Web::Client.new({token: Rails.application.credentials.slack[:admin_token]})
      client.chat_postMessage(channel: 'C014281L42H', text: "新規登録：#{current_user.profile.name}：#{booking.date}/#{booking.start_time}〜")
    end
    redirect_to attendances_path(:date => params[:date]), notice: notice
  end

  def slack
    now = Time.current
    logger.debug "#{now.hour+1}:00"
    bookings = Booking.where(:date => Date.current, :start_time => "#{now.hour+1}:00")
    client = Slack::Web::Client.new({token: Rails.application.credentials.slack[:admin_token]})
    logger.debug bookings.length
    for booking in bookings do
      message = "#{booking.user.profile.name}さん\n#{booking.date}/#{booking.start_time}〜 1on1の予定が入っています"
      client.chat_postMessage(channel: 'C014281L42H', text: message)
      client.chat_postMessage(channel: 'U010H9L1LR0', text: message)
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
