json.extract! track, :id, :album_id, :title, :ord, :lyrics, :bonus_track, :created_at, :updated_at
json.url track_url(track, format: :json)
