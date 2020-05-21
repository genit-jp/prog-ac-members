require "net/http"
require "json"
class DailyReportsController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, except:  [:slack]
  protect_from_forgery except: [:slack]

  def slack
    token = Rails.application.credentials.slack[:daily_reports_token]
    channel = Rails.application.credentials.slack[:daily_reports_channel]
    date = params[:date] ? DateTime.parse(params[:date]) : DateTime.current
    starttime = date.yesterday.to_i
    endtime = date.to_i

    uri = URI.parse("https://slack.com/api/conversations.history?token=#{token}&channel=#{channel}&oldest=#{starttime}&latest=#{endtime}&limit=500")
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    for message in json['messages'] do
      if message['type'] == 'message' and message['client_msg_id'] then
          report = DailyReport.find_or_initialize_by(id: message['client_msg_id'])
          report.slack_user_id = message['user']
          report.text = message['text']
          report.ts = DateTime.strptime(message['ts'],'%s')
          report.team = message['team']
          logger.debug report
          report.save
      end
    end
    render :plain => 'ok', :status => 200
  end

  private

    def daily_report_params
      params.require(:daily_report).permit(:id, :text, :ts, :slack_user_id, :team)
    end

end
