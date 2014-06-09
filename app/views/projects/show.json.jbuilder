json.extract! @project, :id, :project_number, :created_at, :updated_at
json.site_visit @project.site_visit, :id, :street_address, :street_address2, :city, :state, :zip, :latitude, :longitude, :date

json.preproposal_conference @project.preproposal_conference, :id, :street_address, :street_address2, :city, :state, :zip, :latitude, :longitude, :date

json.attachments @project.documents do |document|
  json.(document, :id, :created_at, :updated_at)
  json.file_size document.document_file_size
  json.filename document.document_file_name
  json.content_type document.document_content_type
end

json.contracting_officer @project.contracting_officer, :id, :first_name, :last_name, :email_address, :created_at, :updated_at

json.questions @project.questions, :id, :body

json.plan_holders @project.plan_holders do |planholder|
  json.project planholder.project, :id, :name, :project_number, :closing_date, :question_closing_date

  json.vendor do |json|
    json.(planholder.company, :id, :name, :street_address, :street_address2, :city, :state, :zip, :phone_number)
    json.person do |json|
      json.(planholder.user, :id, :first_name, :last_name, :email)
    end
  end
end
