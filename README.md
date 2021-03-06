# MakersBnB

A clone of AirBnB, built with Ruby, Sinatra, HTML, CSS (Bootstrap), and a little JavaScript.

Registered users can:
- Log in and out.
- List rooms.
- Hire / book rooms depending on date availability.

## Databases
- `makersbnb`
- `makersbnb_test`

### "Spaces" table

| ID | Title (60) | Description | Price |
| -- | -------- | --- | --- |
| 1  | Space A  | Description A | 50.00 |
| 2  | Space B  | Description B | 45.85 |

### "Users" table

| ID | email (120) UNIQUE | password (120), hashed |
| -- | -------- | --- |
| 1  | test@test.com  | pwd123 |
| 2  | tost@tost.com  | wpd231 |

### "Bookings" table

| ID | start_date | end_date | spaces_id
| -- | -------- | --- | --- |
| 1  | 2022-02-27  | 2022-02-28 | 1
| 2  | 2022-03-01  | 2022-03-08 | 1

## To set up

- Clone the repository and `cd` into the directory.
- Run `bundle` to install dependencies.
- [Create the two databases with PostgreSQL](https://www.postgresql.org/docs/9.0/sql-createdatabase.html)
- For each, run the queries in `/db/migrations` to create the tables.
- From the `makersbnb` directory, launch `rackup`.
- From your browser, visit `localhost:portnumber`, where `portnumber` is shown in terminal by `rackup`.
- Enjoy!

## MVP

- [x] Listing a space.
- [x] Being able to see all spaces.
- [x] Book an avaliable space.

## Extra features
- [x] User registration (with unique email address).
- [x] Log in and log out.
- [x] Description and price per listing.
- [x] Date range of availability per listing.
- [x] Some style, fonts, logo.
- [ ] Multiple listings per user.
- [ ] ...and more!

## User Stories

```
As a user,
So that I can rent-out my spareroom, 
I would like to list a new space. 

As a user,
So that I can rent-out all of my sparerooms,
I would like to list to list multiple spaces. 

As a user,
So that I can use the web-app,
I would like to register and create an account.

As a registered user,
So that I can list or rent-out a space,
I would like to log-in to my account.

As a user,
So that I can identify my space,
I would like to add a title/name to my space.

As a user,
So that I can sell and advertise my space,
I would like to add a short description of the space.

As user,
So that the customer is aware of how much the space costs,
I would  like to  add a price per night rate to the space.

As a owner,
So that the customner is aware of avalible dates,
I would like to offer a range of availblity dates.

As a registered user,
So that I can successfully hire a space for one night,
I can request a space for one night.

As a owner,
So that I can sucessfully sell a space for one night,
I can approve customer requests.

As a user,
So that I never book an occupied space,
Once the space is booked, the dates are unavailable.

As a user,
So that I have fair dibs on booking a space,
Until a booking is confirmed, it will remain available.
```