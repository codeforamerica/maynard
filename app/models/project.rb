require 'ri_cal'

class Project < ActiveRecord::Base
  has_many :questions

  has_many :plan_holders

  has_many :documents, as: :attachable, dependent: :destroy do
    def filenames
      collect { |doc| doc.document.url }
    end
  end

  has_one :preproposal_conference

  has_one :site_visit

  belongs_to :contracting_officer, counter_cache: true

  validates :project_number, presence: { message: "must be provided." }
  validates :name, presence: true, presence: { message: "must be provided." }

  #validates :closing_date, presence: { message: "must be provided." }
  #validates :question_closing_date, presence: { message: "must be provided." }

  validate :question_closing_date_before_closing_date

  validates_uniqueness_of :project_number

  accepts_nested_attributes_for :contracting_officer
  accepts_nested_attributes_for :documents, allow_destroy: true
  accepts_nested_attributes_for :preproposal_conference, allow_destroy: true
  accepts_nested_attributes_for :site_visit, allow_destroy: true

  attr_readonly :mail_hash

  before_create :generate_mail_hash

  DATE_FORMAT = "%m/%d/%Y"
  TIME_DATE_FORMAT = '%m/%d/%Y @ %H:%M %p'
  FULL_DATE_FORMAT = '%A, %B %e, %Y at %l:%M'
  JSON_DATE_FORMAT = '%Y-%m-%dT%H:%M:%S%z'

  def closing_date=(date)
    write_attribute(:closing_date, DateTime.strptime(date, DATE_FORMAT)) unless date.blank?
  end

  def question_closing_date=(date)
    write_attribute(:question_closing_date, DateTime.strptime(date, DATE_FORMAT)) unless date.blank?
  end

  def question_closing_date_before_closing_date
    errors.add(:base, "Question closing date occur before project closing date.") unless question_closing_date.to_i < closing_date.to_i # Unix timetsamps only!
  end

  def inbound_email_address
    head, tail = Postmark::Setup::INBOUND_EMAIL_ADDRESS.split('@')
    "#{ head }+#{ mail_hash }@#{ tail }"
  end

  def formatted_date(closing_date)
    self.closing_date.strftime(TIME_DATE_FORMAT)
  end

  def name_with_project_number
    "#{ self.project_number } - #{ self.name }" unless self.project_number.blank?
  end

  def to_ics
    cal = RiCal.Calendar do |cal|
      cal.prodid = "-//Code for America + City of Atlanta//ATL Supply//EN"
    end

    if self.preproposal_conference
      pp_conf = RiCal::Component::Event.new
      pp_conf.summary = "Pre-proposal conference for #{ name }."
      pp_conf.description = "Pre-proposal conference for #{ name }."
      pp_conf.transp = "OPAQUE"
      pp_conf.dtstamp = created_at.getutc
      pp_conf.dtstart = preproposal_conference.date.getutc
      cal.add_subcomponent(pp_conf)
      #pp_conf.start =
    end

    cal.to_s
  end

  private
  def generate_mail_hash
    self.mail_hash = SecureRandom.hex(8)
  end
end
