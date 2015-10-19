json.array!(@wikis) do |wiki|
  json.extract! wiki, :id, :blob, :name
  json.url wiki_url(wiki, format: :json)
end
