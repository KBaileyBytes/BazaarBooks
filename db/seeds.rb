# require "csv"
# require "ruby-progressbar"

# User.delete_all
# Province.delete_all
# BookGenre.delete_all
# Genre.delete_all
# BookFormat.delete_all
# Format.delete_all
# AdminUser.delete_all
# Book.delete_all
# Author.delete_all

# ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='users';")
# ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='provinces';")
# ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='books';")
# ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='genres';")
# ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='formats';")
# ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='book_genres';")
# ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='book_formats';")
# ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='authors';")
# ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='admin_user';")

# provinces = [
#   {
#     "name": "Alberta",
#     "pst":  0,
#     "gst":  0.05,
#     "hst":  0
#   },
#   {
#     "name": "British Columbia",
#     "pst":  0.07,
#     "gst":  0.05,
#     "hst":  0
#   },
#   {
#     "name": "Manitoba",
#     "pst":  0.07,
#     "gst":  0.05,
#     "hst":  0
#   },
#   {
#     "name": "New Brunswick",
#     "pst":  0,
#     "gst":  0,
#     "hst":  0.15
#   },
#   {
#     "name": "Newfoundland and Labrador",
#     "pst":  0,
#     "gst":  0,
#     "hst":  0.15
#   },
#   {
#     "name": "Northwest Territories",
#     "pst":  0,
#     "gst":  0.05,
#     "hst":  0
#   },
#   {
#     "name": "Nova Scotia",
#     "pst":  0,
#     "gst":  0,
#     "hst":  0.15
#   },
#   {
#     "name": "Nunavut",
#     "pst":  0,
#     "gst":  0.05,
#     "hst":  0
#   },
#   {
#     "name": "Ontario",
#     "pst":  0,
#     "gst":  0,
#     "hst":  0.13
#   },
#   {
#     "name": "Prince Edward Island",
#     "pst":  0,
#     "gst":  0,
#     "hst":  0.15
#   },
#   {
#     "name": "Quebec",
#     "pst":  0.09975,
#     "gst":  0.05,
#     "hst":  0
#   },
#   {
#     "name": "Saskatchewan",
#     "pst":  0.06,
#     "gst":  0.05,
#     "hst":  0
#   },
#   {
#     "name": "Yukon",
#     "pst":  0,
#     "gst":  0.05,
#     "hst":  0
#   }
# ]

# provinces.each do |province|
#   prov = Province.create(
#     name: province[:name].to_s,
#     pst:  province[:pst].to_d,
#     gst:  province[:gst].to_d,
#     hst:  province[:hst].to_d
#   )

#   puts prov.errors.full_messages unless prov.valid?
# end

# puts "Created #{Province.count} provinces."

# 50.times do
#   province = Province.find(rand(1..provinces.count))
#   user = province.users.create(
#     email:    Faker::Internet.email,
#     password: "password"
#   )

#   puts "Error: #{user.errors.full_messages}" unless user and user&.valid?
# end

# Province.find(rand(1..Province.count)).users.create(
#   email:    "user@test.com",
#   password: "password"
# )

# Province.find(rand(1..Province.count)).users.create(
#   email:    "admin@test.com",
#   password: "password",
#   is_admin: true
# )

# puts "Created #{User.count} users."

# if Rails.env.development?
#   AdminUser.create!(email: "admin@example.com", password: "password",
#                     password_confirmation: "password")
# end

# puts "Loading books..."

# csv_data = File.read(Rails.root.join("db/main_dataset.csv"))

# books = CSV.parse(csv_data, headers: true, encoding: "utf-8")

# books.each_with_index do |book, index|
#   author = Author.find_or_create_by(name: book["author"])

#   if author and author&.valid?
#     new_book = author.books.create(
#       title:          book["name"],
#       average_rating: book["book_depository_stars"].to_d * 2,
#       isbn:           book["isbn"],
#       page_count:     rand(200..1000),
#       price:          book["price"].to_d,
#       path:           book["img_paths"]
#     )

#     if new_book and new_book&.valid?
#       genre = Genre.find_or_create_by(name: book["category"])
#       format = Format.find_or_create_by(name: book["format"])

#       if genre and format
#         book_format = BookFormat.create(
#           book:   new_book,
#           format: format
#         )
#         book_genre = BookGenre.create(
#           book:  new_book,
#           genre: genre
#         )

#         unless book_format and book_genre
#           puts "Error #{book_format.errors.full_messages}\n#{book_genre.errors.full_messages}"
#         end
#       else
#         puts "Error: #{genre.errors.full_messages} #{format.errors.full_messages}"
#       end
#     else
#       puts "Error: #{new_book.errors.full_messages}"
#     end
#   else
#     puts "Error: #{author.errors.full_messages}"
#   end

#   completed_percentage = ((index + 1).to_f / books.count) * 100
#   printf "\rBooks: %.2f%%", completed_percentage
# end

# puts "\nCreated: \n\tAuthors: #{Author.count}\n\tBooks: #{Book.count}\n\tGenres: #{Genre.count}\n\tFormats: #{Format.count}\n\tBookGenres: #{BookGenre.count} \n\tBookFormats: #{BookFormat.count}"
# puts "Done."

# puts "Attaching images to each book..."
# sleep(1)

# Book.where('id >= 26100').find_each(batch_size: 500) do |book|
#   file_path = "#{Rails.root.join("app/assets/images/#{book.path}")}"

#   if File.exist?(file_path) and !book.image.attached?
#     book.image.attach(io: File.open(file_path), filename: "book_cover.jpg",
#                           content_type: "image/jpg")
#   end

#   sleep(0.25)
#   puts book.id
# end

Order.delete_all
OrderItem.delete_all

ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='orders';")
ActiveRecord::Base.connection.execute("DELETE FROM sqlite_sequence WHERE name='order_items';")


User.all.each do |user|
  puts "User Id: #{user.id}"
  orders = rand(1..8) # Adjust the range for the number of orders per user
  puts "Number Of Orders: #{orders}"

  orders.times do |i|
    order = user.orders.create(
      order_status: "Pending", # Change as needed
      payment_status: "Pending", # Change as needed
      payment_method: "Credit Card", # Change as needed
      total_amount: 0 # Will be updated below
    )

    order_items_count = rand(1..5) # Adjust the range for the number of order items per order
    puts "Order #{i + 1} has #{order_items_count} order items."

    order_items_count.times do |j|
      book = Book.order("RANDOM()").first # Select a random book
      unit_quantity = rand(1..3) # Adjust the range for the quantity of each book

      order_item = order.order_items.create(
        book_id: book.id,
        unit_quantity: unit_quantity,
        unit_price: book.price,
        subtotal: unit_quantity * book.price
      )

      order.total_amount += order_item.subtotal
      order.save
      puts "Order Item: #{j + 1}\n\tBook ID: #{book.id}\n\tQuantity: #{unit_quantity}"
    end
  end
end