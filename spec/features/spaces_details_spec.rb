require_relative 'web_helpers'

feature 'Book a Request' do

  before [:each] do
    login
    add_space
    click_link 'Details'
  end

  scenario 'User cannot view the drop down menu to select a date when they own the property' do
    expect(page).not_to have_content 'Make a booking request'
  end

  scenario 'User can see the update and delete space buttons when they own the property' do
    expect(page).to have_content 'Update Space'
    expect(page).to have_content 'Delete Space'
  end

  scenario 'User can see the drop down menu to select a date when they do not own the property' do
    sign_out
    login_second_user
    click_link 'Details'
    expect(page).to have_content 'Make a booking request'
  end

end