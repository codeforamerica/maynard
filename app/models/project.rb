class Project < ActiveRecord::Base
  has_many :questions

  belongs_to :contracting_officer, counter_cache: true

  validates :project_number, presence: true
  validates :name, presence: true

  validates :closing_date, presence: true
  validates :question_closing_date, presence: true

  validates_uniqueness_of :project_number

  accepts_nested_attributes_for :contracting_officer

  attr_readonly :mail_hash

  before_create :generate_mail_hash

  DATE_FORMAT = "%m/%d/%Y"

  def closing_date=(date)
    write_attribute(:closing_date, DateTime.strptime(date, DATE_FORMAT))
  end

  def question_closing_date=(date)
    write_attribute(:question_closing_date, DateTime.strptime(date, DATE_FORMAT))
  end

  private
  def generate_mail_hash
    self.mail_hash = SecureRandom.hex(8)
  end
end
