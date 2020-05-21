class BookingsController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, except:  []
  def create
    booking = Booking.find_or_initialize_by(:date => Date.parse(params[:date]), :start_time => params[:start_time])
    notice = '予約を受け付けました'
    if booking.user_id then
      notice = '既に予約が入っています'
    else
      booking.user_id = current_user.id
      booking.title = params[:title]
      booking.save
    end
    redirect_to attendances_path(:date => params[:date]), notice: notice
  end

  private

    def booking_params
      params.require(:booking).permit(:user_id, :date, :start_time, :title)
    end

end
