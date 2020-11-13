require_relative 'web_helpers'

feature 'View Reservations' do

  before [:each] do
    login
    add_space
    click_link 'Details'
    sign_out
    login_second_user
    click_link 'Details'
    select_date
  end

  scenario 'user can select a date from the drop down and it will make a request to the owner' do
    click_link 'View Reservations'
    expect(page).to have_content 'test space'
  end

  scenario 'once accepted, the reservation shows under My Spaces: when I own the space' do
    sign_out
    login
    click_link 'View Requests'
    click_button 'Accept'
    click_link 'View Reservations'
    expect(page).to have_content 'test space'
  end

  scenario 'once rejected, the reservation should not show under My Spaces: when I own the space' do
    sign_out
    login
    click_link 'View Requests'
    click_button 'Reject'
    click_link 'View Reservations'
    expect(page).not_to have_content 'test space'
  end

  scenario 'once accepted, the reservation shows under My Trips: when I do not own the space' do
    sign_out
    login
    click_link 'View Requests'
    click_button 'Accept'
    sign_out
    login_second_user
    click_link 'View Reservations'
    expect(page).to have_content 'test space'
  end

  scenario 'once rejected, the reservation should not show under My Trips: when I do not own the space' do
    sign_out
    login
    click_link 'View Requests'
    click_button 'Reject'
    sign_out
    login_second_user
    click_link 'View Reservations'
    expect(page).not_to have_content 'test space'
  end

  scenario 'If i have no reservations for trips, then i want to see a message telling me that' do
    sign_out
    login
    click_link 'View Requests'
    click_button 'Reject'
    click_link 'View Reservations'
    expect(page).to have_content 'You have no trips booked.'
  end

  scenario 'If i have no reservations for spaces, then i want to see a message telling me that' do
    sign_out
    login
    click_link 'View Requests'
    click_button 'Reject'
    click_link 'View Reservations'
    expect(page).to have_content 'You have no reservations.'
  end

end