class Project < ActiveRecord::Base
  has_many :questions

  belongs_to :contracting_officer

  validates_uniqueness_of :project_number

  accepts_nested_attributes_for :contracting_officer
end
