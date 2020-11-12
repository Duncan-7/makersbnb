require_relative 'web_helpers'

feature 'View Requests' do

  before [:each] do
    login
    add_space
    sign_out
    login_second_user
    click_link 'Details'
    select_date
  end

  scenario 'user cannot access their own request to accept or deny it' do
    click_link 'View Requests'
    expect(page).not_to have_content 'Name'
  end

  scenario 'user can view requests for their own space' do
    sign_out
    login
    click_link 'View Requests'
    expect(page).to have_content 'test space'
    expect(page).to have_content 'Booked by: Two'
  end

  scenario 'user can accept a request for their own space' do
    sign_out
    login
    click_link 'View Requests'
    click_button 'Accept'
    expect(page).to have_content 'Reservation accepted'
    expect(page).not_to have_content 'Booked by: Two'
  end

  scenario 'user can reject a request for their own space' do
    sign_out
    login
    click_link 'View Requests'
    click_button 'Reject'
    expect(page).to have_content 'Reservation rejected'
    expect(page).not_to have_content 'Booked by: Two'
  end



end