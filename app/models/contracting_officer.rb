class ContractingOfficer < ActiveRecord::Base
  has_many :projects

  validates :first_name, presence: { message: "must be provided." }
  validates :last_name, presence: { message: "must be provided." }

  def name
    "#{ first_name } #{ last_name }"
  end
end
