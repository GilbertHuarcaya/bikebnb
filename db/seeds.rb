# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first
Bike.destroy_all
User.destroy_all

user = User.create(
  email: "bike@gmail.com", password: "123456", password_confirmation: "123456",
  firstname: "prueba", lastname: "prueba2", city: "lima", phone_number: "123456789",
)
Bike.create(model: "superbike 1", description: "buena bike 2 ", price: 12, user_id: user.id)
