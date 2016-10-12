json.extract! stuff, :id, :name, :user_id, :pickup_location, :return_location, :availability, :available_date, :created_at, :updated_at
json.url stuff_url(stuff, format: :json)