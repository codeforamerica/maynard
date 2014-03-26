require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  test "project should have a number" do
    project = Project.new
    assert !project.save, "Saved project without a project number"
  end

  test "project should have a name" do
    project = Project.new
    assert !project.save, "Saved project without a name"
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
  end

  test "project should have project closing date" do
    project = Project.create(name: "Super Excellent Project", project_number: "9500-LX", question_closing_date: "06/25/2035")
    assert !project.save, "Saved project without closing date."
  end
end
