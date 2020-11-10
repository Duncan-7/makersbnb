require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'makersbnb_test')
  connection.exec("TRUNCATE users CASCADE;")
end

def create_user
  User.create(username: 'Foo', email: 'foo@example.com', password: 'password')
end