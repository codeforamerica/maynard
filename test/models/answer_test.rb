require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  test "should have body" do
    answer = Answer.new
    assert !answer.save, "Saved answer without the actual answer."
    assert_equal "must be provided.", answer.errors[:body][0]
  end
end
