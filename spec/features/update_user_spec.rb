feature 'update user' do
  before(:each) do
    user = create_user
    visit '/login'
    fill_in :email, with: 'foo@example.com'
    fill_in :password, with: 'password'
    click_button 'Login'
    visit "/users/#{user.id}"
    click_link 'Edit Details'
  end
  
  scenario 'updating details' do
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
    fill_in :username, with: 'New Name'
    fill_in :email, with: 'barfoo@example.com'
    fill_in :password, with: 'not my password'
    click_button 'Update'
    expect(page).to have_content 'Update Profile'
    expect(page).to have_content 'Update failed'
    expect(User.all.last.username).to eq 'Foo'
  end
end