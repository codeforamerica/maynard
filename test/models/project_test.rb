require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "project should have a number" do
    project = Project.new(name: "Super Excellent Awesome Project", closing_date: "05/15/2019", question_closing_date: "05/05/2019")
    assert !project.save, "Saved project without a project number"
    assert_equal "must be provided.", project.errors[:project_number][0]
  end

  test "project should have a name" do
    project = Project.new
    assert !project.save, "Saved project without a name"
    assert_equal "must be provided.", project.errors[:name][0]
  end

  test "project should have a mail hash when created" do
    project = Project.create(name: "Awesome project", project_number: "9999-XL", closing_date: "05/15/2019", question_closing_date: "04/29/2019")
    assert !project.mail_hash.blank?, "Mail hash was not generated upon create!"
  end

  test "project mail hash shouldn't change" do
    project = Project.create(name: "Super awesome project", project_number: "9997-PL")
    assert_raise ActiveRecord::ActiveRecordError do
      project.update_attribute(:mail_hash, "muppets-89999")
    end
  end

  test "project should have a question closing date" do
    project = Project.new(name: "Excellent project", project_number: "9000-XL", closing_date: "03/29/2019")
    assert !project.save, "Saved without a question closing date."
    assert_equal "must be provided.", project.errors[:question_closing_date][0]
  end

  test "project should have project closing date" do
    project = Project.create(name: "Super Excellent Project", project_number: "9500-LX", question_closing_date: "06/25/2035")
    assert !project.valid?, "Saved project without closing date."
    assert_equal "must be provided.", project.errors[:closing_date][0]
  end

  test "question closing date should not be after project closing date" do
    project = Project.create(name: "Super Excellent Project", project_number: "0000-XL", question_closing_date: "05/25/2019", closing_date: "05/15/2019")
    assert !project.valid?, "Question closing date is after project closing date."
    assert_equal "Question closing date should be before project closing date.", project.errors[:base][0]
  end

  test "project should have an inbound email address" do
    project = Project.create(name: "Super excellent email project", project_number: "90000-XL", question_closing_date: "03/29/2019", closing_date: "03/17/2019")
    assert_equal "1953c84f635c00147e27d82abd52fdc6+#{ project.mail_hash }@inbound.postmarkapp.com", project.inbound_email_address
  end
end
