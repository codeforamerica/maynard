class Answer < ActiveRecord::Base
  belongs_to :question, counter_cache: true

  validates :body, presence: { message: "must be provided." }
end
