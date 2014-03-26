class Project < ActiveRecord::Base
  has_many :questions

  belongs_to :contracting_officer, counter_cache: true

  validates :project_number, presence: { message: "must be provided." }
  validates :name, presence: true, presence: { message: "must be provided." }

  validates :closing_date, presence: { message: "must be provided." }
  validates :question_closing_date, presence: { message: "must be provided." }

  validates_uniqueness_of :project_number

  accepts_nested_attributes_for :contracting_officer

  attr_readonly :mail_hash

  before_create :generate_mail_hash

  DATE_FORMAT = "%m/%d/%Y"

  def closing_date=(date)
    write_attribute(:closing_date, DateTime.strptime(date, DATE_FORMAT)) unless date.blank?
  end

  def question_closing_date=(date)
    write_attribute(:question_closing_date, DateTime.strptime(date, DATE_FORMAT)) unless date.blank?
  end

  private
  def generate_mail_hash
    self.mail_hash = SecureRandom.hex(8)
  end
end
