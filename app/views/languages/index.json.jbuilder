json.array!(@languages) do |language|
  json.extract! language, :id, :name, :local, :acronym
  json.url language_url(language, format: :json)
end
