json.array!(@projects) do |project|
  json.extract! project, :id, :project_number
  json.url project_url(project, format: :json)
end
