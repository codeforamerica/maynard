json.array!(@questions) do |question|
  json.extract! question, :id, :body, :project_id, :user_id
  json.url question_url(question, format: :json)
end
