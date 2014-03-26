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
    project = Project.create(name: "Awesome project", project_number: "9999-XL")
    assert !project.mail_hash.blank?
  end
end
