require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "should make sure a company has a name" do
    company = Company.new
    assert !company.save, "Saved without a name"
    assert_equal "must be provided.", company.errors[:name][0]
  end
end
