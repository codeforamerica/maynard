module ApplicationHelper
  def required_field
    raw(%{ <span style="color: #c7254e; font-weight: bold;">*</span> })
  end
end
