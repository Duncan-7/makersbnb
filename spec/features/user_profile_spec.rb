require_relative 'web_helpers'

feature 'update user' do

  before [:each] do
    login
    click_link 'Profile'
  end
  
  scenario 'updating details' do
    click_link 'Edit Details'
    fill_in :username, with: 'New Name'
    fill_in :email, with: 'barfoo@example.com'
    fill_in :password, with: 'password'
    click_button 'Update'
    expect(page).to have_content 'Username: New Name'
    expect(page).to have_content 'Email: barfoo@example.com'
    expect(page).to have_content 'Account updated'
    expect(User.all.last.username).to eq 'New Name'
  end

  scenario 'failed update' do
    click_link 'Edit Details'
    fill_in :username, with: 'New Name'
    fill_in :email, with: 'barfoo@example.com'
    fill_in :password, with: 'not my password'
    click_button 'Update'
    expect(page).to have_content 'Update Profile'
    expect(page).to have_content 'Update failed'
    expect(User.all.last.username).to eq 'Foo'
  end
end

feature 'delete' do

  before [:each] do
    login
    click_link 'Profile'
  end

  scenario 'User deletes their account' do
    click_link 'Delete Account'
    expect(current_path).to eq '/signup'
    expect(page).to have_content 'Account deleted'
  end

end

feature 'details' do

  before [:each] do
    login
    click_link 'Profile'
    add_space
  end

  scenario 'user can view the details of their spaces' do
    click_link 'Details'
    expect(current_path).to include '/spaces'
    expect(page).to have_content('Price: £10')
  end
end