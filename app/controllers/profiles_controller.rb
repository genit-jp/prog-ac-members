class ProfilesController < InheritedResources::Base
  before_action :authenticate_user!, except:  []
  def index
    @profiles = Profile.joins(:user).where("is_active = ?", true)
  end
  def edit
    @profile = Profile.find_or_create_by(id: current_user.id, user_id: current_user.id)
  end
  private

    def profile_params
      params.require(:profile).permit(:user_id, :name, :name_kana, :icon_image, :pr_image, :goal, :title, :message, :description)
    end

end
