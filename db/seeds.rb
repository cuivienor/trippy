# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



location1 = Location.create({name: "New York", google_place: "ChIJOwg_06VPwokRYv534QaPC8g", latlong: "40.7127837, -74.0059413"})

poi1 = Poi.create({name: "St. Paul's Chapel", google_place:"ChIJ-wHkrBlawokRjCiym7MbolM", latlong:"40.71695, -74.008935"})
poi2 = Poi.create({name: "Midtown Comics Downtown", google_place:"ChIJhb4pSz1awokRMqAUarOuIB8", latlong:"40.714652, -74.004648"})


user1= User.create ({username: "sally", first_name: "sally", last_name: "smith", password_digest: "password", email:"sally@email.com"})

trip1 = Trip.create({map_image: "image.img", user_id: user1.id, location_id: location1.id})



trip1.poi << poi1
trip1.poi << poi2


user1.poi << poi1
user1.poi << poi2



