class ArticlesController < InheritedResources::Base
  before_action :authenticate_user!, except:  []

  private

    def article_params
      params.require(:article).permit(:title, :description, :priority, :is_active)
    end

end
