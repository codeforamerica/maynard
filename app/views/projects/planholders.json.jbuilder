json.array!(@planholders) do |planholder|
  json.project do |json|
    json.(planholder.project, :id, :name, :project_number, :closing_date, :question_closing_date)
  end

  json.vendor do |json|
    json.(planholder.company, :id, :name, :street_address, :street_address2, :city, :state, :zip, :phone_number)
    json.person do |json|
      json.(planholder.user, :id, :first_name, :last_name, :email)
    end
  end
end
