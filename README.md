# Trippy

Disclaimer: This group project was done as part of a web development bootcamp at General Assembly. Original source can be found at the [group repo](https://github.com/Project-3-WDI/trippy). This fork has fixed minor issues. Original contributors are: [James Leisy](https://github.com/jimmyb0b), [Johnathan Chei](https://github.com/Krazian), [Peter Petrov](https://github.com/pppetrov)

This project was created with the traveler in mind. When traveling to a new destination, it can be cumbersome to jump between mutiple sites just to find interesting points of interest at any destination. Our app solves this problem, by allowing a user to easily search a location and get a list of spots to checkout in that area. The user can then bookmark any of these options and create a trip, or save them for later. Once a trip is created, the user will get step by step directions to each of the choosen places.

# User Stories
- A user can search for destinations
- A user can see a list of popular tourist locations (POIs) at a destination
- A user can bookmark POIs they are interested in
- A user can explore bookmarked POIs based on destination
- A user can create a trip from up to 6 of their POIs at a given location by supplying their starting location. The trip constitutes a static map with the most efficient walking directions to visit all POIs starting and ending at the supplied starting location, and a list of the walking directions. 
- A user can save the trip.
- A user can explored saved trips based on location.

# The Code
This is an entirely Rails app and styling done with some minimal [pure.css](purecss.io). The database is implemented on PostgreSQL.

![ERD](readme_stuff/trippy_erd.png)

A user has their own POIs and their own Locations through POIs, since each POI is associated with a Location. Users also independently have their own Trips, where each trip is associated with many POIs and a respective location. All information is fetched from Google's Places and Maps APIs.

When a user searches for a location a request is made to the ```place/textsearch``` endpoint to match it to its google id. After that a request is made to the ```place/nearby``` endpoint to fetch a list of top POIs for that location after which a request is made to the ```place/details``` endpoint for each POI to fetch its details, and further a request is made to the ```api/place/photo``` end point to get a photo. A call is also made to the Maps API to fetch a static map showing all POIs on a map.

A user is then allowed to bookmark any number of the available POIs. This action writes to the database, saving relevant information for each one.
On the location show page a user can explore all previously saved POIs fetched from the local db. Upon creation of the trip a request is made to the Directions API to get instructions and a static map with the path. Upon save this information is written to our sql db.

User authentication is cookie based using Rails' session.

# Further work
Further work will focus on allowing users to edit and delete their trips, implement a dynamic map for displaying POIs, allowing for a user to load more POIs, or search for specific ones. 
