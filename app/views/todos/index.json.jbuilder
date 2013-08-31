json.array!(@todos) do |todo|
  json.extract! todo, :todo
  json.url todo_url(todo, format: :json)
end
