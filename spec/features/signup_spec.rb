require_relative 'web_helpers'
feature 'signup' do
  scenario 'signing up' do
    sign_up
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

  scenario 'going back' do
    visit '/signup'
    click_button 'back'
    expect(page).to have_content 'Log In'
  end
end
