json.array!(@pages) do |page|
  json.extract! page, :id, :blob, :name, :content, :wiki_id
  json.url page_url(page, format: :json)
end
