module ApplicationHelper
  def required_field
    content_tag(:span, " *", { style: "color: #c7254e; font-weight: bold;" })
  end
end
