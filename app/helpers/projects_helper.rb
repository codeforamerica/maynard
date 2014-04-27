module ProjectsHelper
  def file_upload_info(document)
    return if document.nil? || document.created_at.blank?
    "Uploaded #{ document.created_at.localtime.strftime('%m/%d/%Y @ %l:%M%P') }"
  end

  def file_uploadname(doc)
    content_tag(:strong, doc.document.original_filename) + "<br />".html_safe
  end

  def file_upload_remove_btn(doc)
    unless doc.document.original_filename.blank?
      "<br /><br />".html_safe + content_tag(:button, nil, class: "btn btn-small btn-danger", id: "doc-#{ doc.id }-remove-btn") do
        content_tag(:span, nil, class: "glyphicon glyphicon-remove") + " Remove"
      end
    end
  end

  def add_file_btn

  end
end
