class Company < ActiveRecord::Base
  validates :name, presence: { message: "must be provided." }
end
