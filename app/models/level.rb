class Level < ApplicationRecord
  belongs_to :user

  def to_s
    "#{self.stage}-#{self.level}"
  end

end
