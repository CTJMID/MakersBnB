# MakersBnB

## High Level Porjkect Specification
We are building a clone of AirBnB, where users, can log-in to do:
- can list rooms
- hire/books rooms

## User Stories

```As a user 
So that I can rent-out my spareroom 
I would like to list a new space 

As a user
So that I can rent-out all of my sparerooms  
I would like to list to list multiple spaces  

As a user
So that I can use the web-app
I would like to register and create an account

As a registered user
So that I can list or rent-out a space
I would like to log-in to my account

As a user
So that I can idenitfy my space
I would like to add a title/name to my space

As a user
So that I can sell and advertise my space
I would like to add a short description of the space

As user
So that the customer is aware of how much the space costs
I would  like to  add a price per night rate to the space

As a owner
So that the customner is aware of avalible dates
I would like to offer a range of availblity dates

As a registered user
So that I can successfully hire a space for one night
I can request a space for one night

As a owner
So that I can sucessfully sell a space for one night
I can approve customer requests

As a user
So that I never book an occupied space
Once the space is booked,the dates are unavailable

As a user
So that I have fair dibs on booking a space
Until a booking is confirmed, it will remain available

```

## MVP

Listing a space, being able to see all spaces, book an avaliable space.

## Databases
- makersbnb
- makersbnb_test

| ID | Title(60) |
| -- | -------- |
| 1  | Space A  |
| 2  | Space B  |

## To set up

- Make two databases, listed above
- For each, run the commands in /db/migrations