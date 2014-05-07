class Meeting < ActiveRecord::Base
  def date=(_date)
    write_attribute(:date, DateTime.strptime(_date, Project::DATE_FORMAT)) unless _date.blank?
  end
end
