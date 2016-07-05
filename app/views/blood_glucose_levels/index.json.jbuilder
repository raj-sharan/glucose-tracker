json.array!(@blood_glucose_levels) do |blood_glucose_level|
  json.extract! blood_glucose_level, :id, :user, :data, :recorded_at
  json.url blood_glucose_level_url(blood_glucose_level, format: :json)
end
