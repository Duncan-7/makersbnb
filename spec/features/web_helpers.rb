def create_user
  User.create(username: 'Foo', email: 'foo@example.com', password: 'password')
end

def create_second_user
  User.create(username: 'Two', email: 'two@example.com', password: 'password')
end

def login
  @user = create_user
  visit '/login'
  fill_in :email, with: 'foo@example.com'
  fill_in :password, with: 'password'
  click_button 'Login'
end

def login_second_user
  create_second_user
  visit '/login'
  fill_in :email, with: 'two@example.com'
  fill_in :password, with: 'password'
  click_button 'Login'
end

def sign_up
  visit '/signup'
  fill_in :username, with: 'foo'
  fill_in :email, with: 'foobar@example.com'
  fill_in :password, with: 'password'
  click_button 'Signup'
end

def add_space
  visit '/spaces/new'
  fill_in :name, with: 'test space'
  fill_in :description, with: 'this is a space you would like to stay in'
  fill_in :price, with: '10'
  click_button 'add_space'
end

def sign_out
  click_link 'Logout'
end
