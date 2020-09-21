class PurposesController < InheritedResources::Base
  def new
    @now = Date.current
    @purpose = Purpose.new(:user_id => current_user.id, :title => "#{@now.year}年#{@now.month+1}月：XXXXX")
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
      params.require(:purpose).permit(:user_id, :title, :text, :result)
    end

end
