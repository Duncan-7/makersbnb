feature 'login' do
  scenario 'logging in' do
    create_user
    visit '/login'
    fill_in :email, with: 'foo@example.com'
    fill_in :password, with: 'password'
    click_button 'Login'
    expect(page).to have_content 'Spaces:'
    expect(page).to have_content 'Logout'
  end

  scenario 'failed login' do
    visit '/login'
    click_button 'Login'
    expect(page).to have_content 'Email:'
    expect(page).to have_content 'Invalid email or password'
  end
end