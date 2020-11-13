def create_user
  User.create(username: 'Foo', email: 'foo@example.com', password: 'password')
end

def create_second_user
  User.create(username: 'Two', email: 'two@example.com', password: 'password')
end

def create_third_user
  User.create(username: 'Three', email: 'three@example.com', password: 'password')
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

def login_third_user
  create_third_user
  visit '/login'
  fill_in :email, with: 'three@example.com'
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

def add_second_space
  visit '/spaces/new'
  fill_in :name, with: 'second place'
  fill_in :description, with: 'why not book this?'
  fill_in :price, with: '25'
  click_button 'add_space'
end

def add_incomplete_space
  visit '/spaces/new'
  fill_in :name, with: ''
  fill_in :description, with: 'this is a space you would like to stay in'
  fill_in :price, with: '10'
  click_button 'add_space'
end

def select_date
  select ((Time.now).day+1).to_s, :from => "date"
  click_button 'Request'
end

def update_space
  fill_in :name, with: 'not a test space'
    fill_in :description, with: 'some may say that this has changed. They are correct'
    fill_in :price, with: '4000'
    click_button 'update_space'
end

def incomplete_update_space
  fill_in :name, with: 'not a test space'
  fill_in :description, with: 'some may say that this has changed. They are correct'
  fill_in :price, with: ''
  click_button 'update_space'
end

def space_search
  visit '/'
  fill_in :search_date, with: '14/11/2020'
  click_button 'Search'
end

def sign_out
  click_link 'Logout'
end
