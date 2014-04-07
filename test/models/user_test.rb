require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "should make sure user has a first name" do
    user = User.new(last_name: "Frog", email: "kermit.the.frog@codeforamerica.org")
    assert !user.save, "Saved without a first name"
  end

  test "should make sure user has a last name" do
    user = User.new(first_name: "Kermit", email: "kermit.the.frog@codeforamerica.org")
    assert !user.save, "Saved without a last name"
  end

  test "should make sure user has an email address" do
    user = User.new(first_name: "Kermit", last_name: "Frog")
    assert !user.save, "Saved without an email address"
  end
end
