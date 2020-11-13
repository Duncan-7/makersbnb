require_relative 'web_helpers'
feature 'log_out' do
  scenario 'allows users to log out once they have logged in' do
    login
    click_link 'Logout'
    expect(page).to have_content('Login')
   # expect(User.user_id).to eq nil 
  end

  scenario 'user cannot log out if they havent logged in' do
    visit'/'
    expect(page).not_to have_content('Logout')
  end

  scenario 'once a user has logged they wont be able to manually get to any of the other extensions' do
    login
    click_link 'Logout'
    visit '/spaces/new'
    expect(current_path).to eq '/login'
  end
end
