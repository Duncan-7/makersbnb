### MakersBnB ###

**How to set up**
```
1. Copy repo to your local machine.
```
```
2. Run bundle install
```
```
3. Run rake db:create
```
```
4. Run rake db:schema:load
```
```
5. Run application rackup or shotgun
```

**How to set up a branch**
```
1. git branch my_branch (creates new branch)
```
```
2. git checkout my_branch (change to the newly created branch)
```
```
3. Git add ./git commit -m (add changes to your branch)
```
```
4. Git push -u origin (pushes your branch to github)
```
```
5. On Github - to merge your branch do:
-> compare & pull request
-> add your pull request comment
-> merge with master
```
```
6. Git pull - always pull newest merges into master and branch from it so you dont have any conflicts when trying to merge your branch
```
```
7. Best Practice = > Your branch name should always reflect the exact work you're doing
```

**User Story 1:**
```
As a user,
So that I can interact with spaces,
I want to be able to sign up for an account.
```
**User Story 2:**
```
As a user,
So that my spaces are protected,
I want to have to sign in to interact with my spaces.
```
**User Story 3:**
```
As a user,
So that others can see what spaces I have available,
I want to be able to create a space with a description, name and price.
```
**User Story 4:**
```
As a user,
So that I can show all my available spaces,
I want to be able to list multiple spaces.
```
**User Story 5:**
```
As a user,
So that I can change a listing,
I want to be able to update my spaces.
```
**User Story 6:**
```
As a user,
So that I can un-list a space,
I want to be able to delete my spaces.
```
**User Story 7:**
```
As a user,
So that I can what spaces I can book,
I want to be able to see what dates are available for the given space.
```
**User Story 8:**
```
As a user, 
So that I can book a space,
I want to be able to select a date from a drop down to send a request.
```
**User Story 9:**
```
As a user, 
So that I can confirm a booking, 
I want to be able to accept a request for a space.
```
**User Story 10:**
```
As a user, 
So that I can deny a booking, 
I want to be able to reject a request for a space.
```
**User Story 11:**
```
As a user, 
So that I can deny a booking, 
I want to be able to reject a request for a space.
```
**User Story 12:**
```
As a user, 
So that no one else can book a space the same day as me, 
I want the date on the space to be unavailable when it has been confirmed.
```
**User Story 13:**
```
As a user, 
So that offers can be made for a non-confirmed space, 
I only want the date to be unavailable if it has been accepted. 
```
**User Story 14:**
```
As a user, 
So that I can see the who has booked my spaces, 
I want to be able to see the reservations that have been made.
```
**User Story 15:**
```
As a user, 
So that I can see the spaces that I have booked, 
I want to be able to see the reservations that I have made.
```
**User Story 16:**
```
As a user, 
So that I can see the spaces available for a given date, 
I want to be able to search the spaces by date.
```
**User Story 17:**
```
As a user, 
In case any of my information changes, 
I want to be able to update my account. 
```
**User Story 18:**
```
As a user, 
In case I decide I no longer want my account, 
I want to be able to delete my account. 
```
**User Story 19:**
```
As a user, 
So that I can stop my active session, 
I want to be able to sign-out of my account. 
```