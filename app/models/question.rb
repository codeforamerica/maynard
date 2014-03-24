class Question < ActiveRecord::Base
  has_many :answers

  belongs_to :project, counter_cache: true
end
