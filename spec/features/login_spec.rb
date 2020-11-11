require_relative 'web_helpers'
feature 'login' do
  scenario 'logging in' do
    create_user
    login
    expect(page).to have_content 'Spaces:'
    expect(page).to have_content 'Logout'
  end

  scenario 'failed login' do
    visit '/login'
    click_button 'Login'
    expect(page).to have_content 'Email:'
    expect(page).to have_content 'Invalid email or password'
  end

  scenario 'allows user to sign up if they dont have an account' do
    visit '/login'
    click_button 'signup'
    expect(page).to have_content 'Sign Up'
  end

  scenario 'users are directed to spaces page' do
    visit '/login'
    click_link 'Home'
    expect(current_path).to eq '/'
    expect(page).to have_content 'Homepage'
    expect(page).not_to have_content 'Details'
  end
end
