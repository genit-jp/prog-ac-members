class PurposesController < InheritedResources::Base
  def new
    @now = Date.current
    @purpose = Purpose.new(:user_id => current_user.id)
  end
  def edit
    @now = Date.current
    super
  end
  def show
    redirect_to profile_path(current_user.profile)
  end

  private

    def purpose_params
      params.require(:purpose).permit(:user_id, :goal6m, :goal3m, :goal1m, :text, :result)
    end
end
