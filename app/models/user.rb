class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :timeoutable, :trackable
  has_one :profile
  has_many :attendances
  has_many :bookings
  has_one :level

  def is_drop_out
    if self.bookings.empty?
      return true
    end
    last_date = self.bookings.order(:date).last.date
    if Date.today - last_date > 14
      return true
    end
    false
  end


end
