class MembersController < ApplicationController
  before_action :authenticate_user!, :require_admin, except:  []
  def index
    day = params[:day] ? params[:day] : 14
    @day = day.to_i
    now = DateTime.now
    from = now.ago(@day.days)
    @fromdate = Date.current.ago(@day.days)
    @profiles = Profile.joins(:user).where("is_active = ?", true)
    @attendances = Attendance.where("date > ?", @fromdate)
    @bookings = Booking.where("date > ?", @fromdate)
    @daily_reports = DailyReport.where("ts > ?", from)
  end
end
