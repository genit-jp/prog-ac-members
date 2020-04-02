class AttendancesController < InheritedResources::Base
    def index
      if params[:date]
        @date = Date.parse(params[:date])
      else
        @date = Date.today
      end
      tomorrow = @date.tomorrow
      @attendances = Attendance.where("starts_at >= ? and starts_at <= ?", @date.to_time.to_datetime, tomorrow.to_time.to_datetime)
      @attendance = @attendances.find_by("user_id = ?", current_user.id)
    end

  private

    def attendance_params
      params.require(:attendance).permit(:user_id, :starts_at, :ends_at)
    end

end
