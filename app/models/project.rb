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

    if preproposal_conference
      pp_conf = RiCal::Component::Event.new
      pp_conf.summary = "Pre-proposal conference for #{ name }."
      pp_conf.description = "Pre-proposal conference for #{ name }."
      pp_conf.transp = "OPAQUE"
      pp_conf.dtstamp = preproposal_conference.created_at.getutc
      pp_conf.dtstart = preproposal_conference.date.getutc
      cal.add_subcomponent(pp_conf)
    end

    if site_visit
      site_v = RiCal::Component::Event.new
      site_v.summary = "Site visit for #{ name }"
      site_v.description = "Site visit for #{ name }."
      site_v.transp = "OPAQUE"
      site_v.dtstamp = site_visit.created_at.getutc
      site_v.dtstart = site_visit.date.getutc
      cal.add_subcomponent(site_v)
    end

    cal.to_s
  end

  def to_json(options = {})
    Jbuilder.encode do |json|
      json.extract! self, :id, :project_number, :name, :created_at, :updated_at

      if site_visit
        json.site_visit self.site_visit, :id, :street_address, :street_address2, :city, :state, :zip, :latitude, :longitude, :date
      end

      if preproposal_conference
        json.preproposal_conference self.preproposal_conference, :id, :street_address, :street_address2, :city, :state, :zip, :latitude, :longitude, :date
      end

      json.attachments self.documents do |document|
        json.(document, :id, :created_at, :updated_at)
        json.file_size document.document_file_size
        json.filename document.document_file_name
        json.content_type document.document_content_type
      end

      if contracting_officer
        json.contracting_officer self.contracting_officer, :id, :first_name, :last_name, :email_address, :created_at, :updated_at
      end

      json.questions self.questions, :id, :body, :answers_count, :created_at, :updated_at

      json.plan_holders self.plan_holders do |planholder|
        json.project planholder.project, :id, :name, :project_number, :closing_date, :question_closing_date

        json.vendor do |json|
          json.(planholder.company, :id, :name, :street_address, :street_address2, :city, :state, :zip, :phone_number)
          json.person do |json|
            json.(planholder.user, :id, :first_name, :last_name, :email)
          end
        end
      end
    end
  end

  private
  def generate_mail_hash
    self.mail_hash = SecureRandom.hex(8)
  end
end
