class HomeController < ApplicationController
  before_action :authenticate_user!, except:  []
  def index
    @date = Date.current
    @profiles = Profile.joins(:user).where("is_active = ?", true)
    @articles = Article.where(:is_active => true).order(priority: "DESC")
    @attendances = Attendance.where("date <= ? and date <= ?", @date.ago(7.days), @date)
    @timelines = []
    for att in @attendances do
      if att.user.profile.present? then
        @timelines.push ["#{att.user.profile.name}#{att.is_remote ? '(リ)' : ''}", att.starts_at, att.ends_at]
      end
    end
  end
end
