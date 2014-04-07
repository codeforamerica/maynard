require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should make sure user has a first name" do
    user = User.new(last_name: "Frog", email: "kermit.the.frog@codeforamerica.org")
    assert !user.save, "Saved without a first name"
  end
end
