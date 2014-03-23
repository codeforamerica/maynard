json.array!(@contracting_officers) do |contracting_officer|
  json.extract! contracting_officer, :id, :first_name, :last_name, :email_address
  json.url contracting_officer_url(contracting_officer, format: :json)
end
