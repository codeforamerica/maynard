class ContractingOfficer < ActiveRecord::Base
  has_many :projects
  
  def name
    "#{ first_name } #{ last_name }"
  end
end
