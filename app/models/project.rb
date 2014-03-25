class Project < ActiveRecord::Base
  has_many :questions

  belongs_to :contracting_officer, counter_cache: true

  validates_uniqueness_of :project_number

  accepts_nested_attributes_for :contracting_officer

  DATE_FORMAT = "%m/%d/%Y"

  def closing_date=(date)
    write_attribute(:closing_date, DateTime.strptime(date, DATE_FORMAT))
  end

  def question_closing_date=(date)
    write_attribute(:question_closing_date, DateTime.strptime(date, DATE_FORMAT))
  end
end
