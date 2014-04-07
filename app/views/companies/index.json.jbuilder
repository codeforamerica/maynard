json.array!(@companies) do |company|
  json.extract! company, :id, :name, :street_address, :street_address2, :city, :state, :zip, :phone_number
  json.url company_url(company, format: :json)
end
