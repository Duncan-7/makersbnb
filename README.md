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

6. Git pull - always pull newest merges into master and branch from it so you dont have any conflicts when trying to merge your branch

7. Best Practice = > Your branch name should always reflect the exact work you're doing 

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

Start with Users

Log in
Sign up
	Username
    email
	Password(encrypted)

View spaces
	Without sign in
		Can view all available spaces
	With sign in
		Can view/book/add/delete/update spaces

Spaces
	Created by a user
	It has a name, price, description & availability

Tasks
-	<em> Create a shared repo </em>
-	<em> Share this repo </em>
-	<em> Learn to use git branches </em>
-	<em> Initialize project (gemfiles, file structure, spec helper etc) </em>
-	<em> Create and set up db </em>
o	<em> User table </em>
	    <em> Username – Text – max length 10 </em>
	    <em> Email – unique email – validate is a working email </em>
	    <em> Password (digest) </em>
o	User has many spaces, but spaces belong to a user </em>
o	<em> Spaces table </em>
	    <em> Name </em>
	    <em> Description </em>
	    <em> Price per night </em>
	    <em> Availability </em>
	    <em> User ID </em>
o	<em> Set up migration files for everyone to set up the same db </em>
-	Views to set up
o	Log in page 
	    Email
	    Password
o	Sign up page
	    Email
	    Password
	    Username
o	Homepage
	    Displays all spaces – see details of each
	    Changes depending on whether the user is logged in
o	Layouts (so that each page is the same and changes depending on the use of the page)
