class HomeController < ApplicationController
  before_action :authenticate_user!, except:  []
  def index
    @profiles = Profile.joins(:user).where("is_active = ?", true)
    @articles = Article.where(:is_active => true).order(priority: "DESC")
  end
end
