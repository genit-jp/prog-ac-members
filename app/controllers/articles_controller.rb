class ArticlesController < InheritedResources::Base
  before_action :authenticate_user!, :require_permitted_user, except:  []

  private

    def article_params
      params.require(:article).permit(:title, :description, :priority, :is_active, :link)
    end

end
