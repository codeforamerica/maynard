require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  test "Question should have a body" do
    question = Question.new
    assert !question.save, "Saved without an actual question!"
    assert_equal "can't be blank", question.errors[:body][0]
  end
end
