class HomeController < ApplicationController
  before_action :authenticate_user!, except:  []
  def index
    @articles = Article.where(:is_active => true).order(priority: "DESC")
  end
end
