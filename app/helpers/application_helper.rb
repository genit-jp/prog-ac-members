module ApplicationHelper
  def self.makeDateTimePastTime(datetime)
    pasttime = DateTime.now.to_i - datetime.to_i
    if pasttime < 60
      return "#{pasttime}秒前"
    elsif pasttime < 60*60
      return "#{pasttime/60}分前"
    elsif pasttime < 60*60*24
      return "#{pasttime/60/60}時間前"
    elsif pasttime < 60*60*24*30
      return "#{pasttime/60/60/24}日前"
    else
      return "#{pasttime/60/60/24/30}ヶ月前"
    end
  end
end
