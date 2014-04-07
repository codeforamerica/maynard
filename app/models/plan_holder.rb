class PlanHolder < ActiveRecord::Base
  belongs_to :company
  belongs_to :project
  belongs_to :user

  delegate :first_name, :last_name, :email, to: :user
  delegate :name, to: :company

  class << self
    def to_csv(options = {})
      CSV.generate(options) do |csv|
        csv << column_names
        all.each do |planholder|
          csv << planholder.attributes.values_at(*column_names)
        end
      end
    end
  end
end
