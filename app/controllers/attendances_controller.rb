class AttendancesController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, except:  [:slack]
  protect_from_forgery except: [:slack]
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.current
    @attendances = Attendance.where("cast(date as text) LIKE ?", @date)
    @attendance = @attendances.find_by(:user_id => current_user.id)
    @timelines = []
    @bookings = Booking.where("cast(date as text) LIKE ?", @date)
    for att in @attendances do
      if att.user.profile.present? then
        @timelines.push ["#{att.user.profile.name}#{att.is_remote ? '(リ)' : ''}", att.starts_at, att.ends_at]
      end
    end
  end

  def create
    attendance = Attendance.find_or_initialize_by(:user_id => current_user.id, :date => Date.parse(params[:date]))
    attendance.start_time = params[:start_time]
    attendance.end_time = params[:end_time]
    attendance.is_remote = params[:is_remote]
    attendance.starts_at = DateTime.parse("#{params[:date]}T#{params[:start_time]}+09:00")
    attendance.ends_at = DateTime.parse("#{params[:date]}T#{params[:end_time]}+09:00")
    if attendance.starts_at.to_i > attendance.ends_at.to_i then
      attendance.ends_at = attendance.starts_at
      attendance.end_time = attendance.start_time
    end
    attendance.save
    redirect_to attendances_path(:date => params[:date])
  end

  def destroy
    Attendance.find(params[:id]).destroy
    flash[:success] = "予定を削除しました"
    redirect_to attendances_path(:date => params[:date])
  end

  def slack
    date = params[:date] ? Date.parse(params[:date]) : Date.current
    attendances = Attendance.where("cast(date as text) LIKE ?", date)
    notifier = Slack::Notifier.new(
        Rails.application.credentials.slack[:webhook_url],
        channel: '#スケジュール',
        username: "メンバーズサイト"
    )
    strdate = date.strftime("%m月%d日(#{%w(日 月 火 水 木 金 土)[date.wday]})")
    schedules = ""
    for attendance in attendances do
      schedules << "#{attendance.user.profile.name} #{attendance.start_time}〜#{attendance.end_time}\n"
    end
    additional = "※変更がある場合は変更内容を、1on1ミーティングをご希望の方は希望時間を、この投稿に返信してください。\n<#C011PQM65BM> を書きましょう。"
    notifier.ping "*#{strdate}の予定*\n#{schedules}\n#{additional}"

    # 金曜日はスケジュールの入力をお願いする
    if date.wday == 5 then
      nextdate = date.since(9.days)
      str_nextdate = nextdate.strftime("%m月%d日(#{%w(日 月 火 水 木 金 土)[nextdate.wday]})")
      notifier.ping "*今日は金曜日です。#{str_nextdate}までの学習予定を(仮でOK)入力してください。*"
    end
    render :text => 'ok', :status => 200

  end

  private

    def attendance_params
      params.require(:attendance).permit(:user_id, :starts_at, :ends_at)
    end

end
