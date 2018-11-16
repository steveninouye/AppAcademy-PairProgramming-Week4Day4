json.extract! album, :id, :band_id, :title, :year, :live, :created_at, :updated_at
json.url album_url(album, format: :json)
