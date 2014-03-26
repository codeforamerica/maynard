require 'test_helper'

class ContractingOfficerTest < ActiveSupport::TestCase
  test "make sure contracting officer has a first name" do
    officer = ContractingOfficer.new
    assert !officer.save, "Saved without first name"
  end

  test "make sure contracting officer has a last name" do
    officer = ContractingOfficer.new
    assert !officer.save, "Saved without last name"
  end

  test "make sure full name comes from ContractingOfficer#name" do
    officer = ContractingOfficer.create(first_name: "Aubrey", last_name: "Graham")
    assert_equal "Aubrey Graham", officer.name
  end
end
