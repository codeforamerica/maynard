class Project < ActiveRecord::Base
  validates_uniqueness_of :project_number
end
