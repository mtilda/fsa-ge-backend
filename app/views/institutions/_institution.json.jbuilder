json.extract! institution, :id, :opeid, :name, :city, :state, :zip, :type, :created_at, :updated_at
json.url institution_url(institution, format: :json)
