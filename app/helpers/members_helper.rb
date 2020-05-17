module MembersHelper
  def self.empty_background_color(val)
    val.blank? ? 'background-color:red' : ''
  end
end
