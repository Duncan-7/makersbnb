feature 'signup' do
  scenario 'signing up' do
    visit '/signup'
    fill_in :username, with: 'foo'
    fill_in :email, with: 'foobar@example.com'
    fill_in :password, with: 'password'
    click_button 'Signup'
    expect(page).to have_content 'Spaces:'
    expect(page).to have_content 'Logout'
    expect(User.all.last.username).to eq 'foo'
  end

  scenario 'failed signup' do
    visit '/signup'
    click_button 'Signup'
    expect(page).to have_content 'Username:'
    expect(page).to have_content 'Invalid details. Please try again.'
    expect(User.all.length).to eq 0
  end
end