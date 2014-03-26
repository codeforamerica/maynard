require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "Question should have a body" do
    question = Question.new
    assert !question.save, "Saved without an actual question!"
  end
end
