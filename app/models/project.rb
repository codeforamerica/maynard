class Project < ActiveRecord::Base
  has_many :questions
  
  validates_uniqueness_of :project_number
end
