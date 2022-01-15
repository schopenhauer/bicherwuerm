json.array!(@books) do |book|
  json.extract! book, :id, :title, :author, :publisher_id, :category_id, :category_id, :language_id, :user_id, :borrower, :description
  json.url book_url(book, format: :json)
end
