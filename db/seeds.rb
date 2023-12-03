User.delete_all
Province.delete_all
AdminUser.delete_all

ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='users';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='provinces';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='admin_user';")

provinces = [
  {
    "name": "Alberta",
    "pst": 0,
    "gst": 0.05,
    "hst": 0
  },
  {
    "name": "British Columbia",
    "pst": 0.07,
    "gst": 0.05,
    "hst": 0
  },
  {
    "name": "Manitoba",
    "pst": 0.07,
    "gst": 0.05,
    "hst": 0
  },
  {
    "name": "New Brunswick",
    "pst": 0,
    "gst": 0,
    "hst": 0.15
  },
  {
    "name": "Newfoundland and Labrador",
    "pst": 0,
    "gst": 0,
    "hst": 0.15
  },
  {
    "name": "Northwest Territories",
    "pst": 0,
    "gst": 0.05,
    "hst": 0
  },
  {
    "name": "Nova Scotia",
    "pst": 0,
    "gst": 0,
    "hst": 0.15
  },
  {
    "name": "Nunavut",
    "pst": 0,
    "gst": 0.05,
    "hst": 0
  },
  {
    "name": "Ontario",
    "pst": 0,
    "gst": 0,
    "hst": 0.13
  },
  {
    "name": "Prince Edward Island",
    "pst": 0,
    "gst": 0,
    "hst": 0.15
  },
  {
    "name": "Quebec",
    "pst": 0.09975,
    "gst": 0.05,
    "hst": 0
  },
  {
    "name": "Saskatchewan",
    "pst": 0.06,
    "gst": 0.05,
    "hst": 0
  },
  {
    "name": "Yukon",
    "pst": 0,
    "gst": 0.05,
    "hst": 0
  },
]

provinces.each do |province|
  prov = Province.create(
    name: province[:name].to_s,
    pst: province[:pst].to_d,
    gst: province[:gst].to_d,
    hst: province[:hst].to_d
  )

  puts prov.errors.full_messages unless prov.valid?
end

puts "Created #{Province.count} provinces."

50.times do
  province = Province.find(rand(1..provinces.count))
  user = province.users.create(
    email: Faker::Internet.email,
    password: "password"
  )

  if user and user&.valid?
    puts "Created #{user.email}"
  else
    puts "Error: #{user.errors.full_messages}"
  end
end

Province.find(rand(1..Province.count)).users.create(
  email: "user@test.com",
  password:"password"
)

Province.find(rand(1..Province.count)).users.create(
  email: "admin@test.com",
  password:"password",
  is_admin: true
)

puts "Created #{User.count} users."

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?