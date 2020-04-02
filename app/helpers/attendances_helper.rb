module AttendancesHelper
  def self.makeTimeMap(date)
    ret = []
    for num in 10..22 do
      datetime = DateTime.parse("#{date.to_s}-#{num}:00+09:00")
      data = [ "#{num}:00", datetime.to_s ]
      ret.push data
    end
    return ret
  end
end
