class ProfilesController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, except:  []
  def index
    @profiles = Profile.joins(:user).where("is_active = ?", true)
  end
  def edit
    @profile = Profile.find_or_create_by(id: current_user.id, user_id: current_user.id)
    @purposes = Purpose.where(:user_id => @profile.user_id).order(created_at: "DESC")
  end
  def show
    @profile = Profile.find(params[:id])
    @purposes = Purpose.where(:user_id => @profile.user_id).order(created_at: "DESC")
  end
  private

    def profile_params
      params.require(:profile).permit(:user_id, :name, :name_kana, :icon_image, :pr_image, :goal, :title, :message, :description, :slack_user_id, :github_id)
    end

end
