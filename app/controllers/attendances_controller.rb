class AttendancesController < InheritedResources::Base
  before_action :authenticate_user!, except:  []
  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
    @attendances = Attendance.where("date == ?", @date)
    @attendance = @attendances.find_by(:user_id => current_user.id)
    @timelines = []
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
    attendance.save
    redirect_to attendances_path(:date => params[:date])
  end

  def destroy
    Attendance.find(params[:id]).destroy
    flash[:success] = "予定を削除しました"
    redirect_to attendances_path(:date => params[:date])
  end

  private

    def attendance_params
      params.require(:attendance).permit(:user_id, :starts_at, :ends_at)
    end

end
