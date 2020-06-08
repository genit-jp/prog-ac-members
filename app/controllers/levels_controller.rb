class LevelsController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, :require_admin, except:  []

  def new
    @level = Level.find_or_initialize_by(:user_id => params[:user_id])
  end

  private

    def level_params
      params.require(:level).permit(:user_id, :start_date, :level, :stage)
    end

end
