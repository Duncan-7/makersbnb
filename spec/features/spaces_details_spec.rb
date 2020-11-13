require_relative 'web_helpers'

feature 'Spaces Details' do

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
  
  scenario 'User cannot see the update and delete space buttons when they do not own the property' do
    sign_out
    login_second_user
    click_link 'Details'
    expect(page).not_to have_content 'Update Space'
    expect(page).not_to have_content 'Delete Space'
  end

  scenario 'Expect the month and year shown to be the current month and year' do
    expect(page).to have_content((Time.now).month)
    expect(page).to have_content((Time.now).year)
  end

  scenario 'Expect the next month/year to be shown when clicking on the arrow' do
    find(:css, '.arrow.right').click
    expect(page).to have_content((Time.now).month+1)
  end

  scenario 'You can select a date with the drop downs' do
    select ('October'), :from => "month"
    select ((Time.now).year+1).to_s, :from => "year"
    click_button 'Go'
    expect(page).to have_content('October')
    expect(page).to have_content((Time.now).year+1)
  end

  scenario 'user can select a date from the drop down and it will confirm that a request has been made' do
    sign_out
    login_second_user
    click_link 'Details'
    select_date
    expect(page).to have_content 'Request sent!'
  end

  scenario 'once a user has requested to stay in a space, the date no longer appears in the drop down for them' do
    sign_out
    login_second_user
    click_link 'Details'
    select_date
    expect(page).not_to have_select('date', :with_options => [(Time.now).day+1])
  end

  scenario 'once a user has requested to stay in a space, the date will still appear in the drop down for other users' do
    sign_out
    login_second_user
    click_link 'Details'
    select_date
    sign_out
    login_third_user
    click_link 'Details'
    select ((Time.now).day+1).to_s, :from => "date"
    expect(page).to have_select('date', :with_options => [(Time.now).day+1])
  end

  scenario 'once a user has requested to stay in a space, the date on the calendar should turn yellow' do
    sign_out
    login_second_user
    click_link 'Details'
    select_date
    expect(page).to have_css '.requested'
  end

  scenario 'once a user request has been accepted, the date no longer appears in the drop down for anyone' do
    sign_out
    login_second_user
    click_link 'Details'
    select_date
    sign_out
    login
    click_link 'View Requests'
    click_button 'Accept'
    sign_out
    login_third_user
    click_link 'Details'
    expect(page).not_to have_select('date', :with_options => [(Time.now).day+1])
  end

  scenario 'once a user request has been accepted, the date on the calendar should turn red' do
    sign_out
    login_second_user
    click_link 'Details'
    select_date
    sign_out
    login
    click_link 'View Requests'
    click_button 'Accept'
    sign_out
    login_second_user
    click_link 'Details'
    expect(page).to have_css '.booked'
  end

  scenario 'once a user request has been rejected, the date will appear in the drop down for everyone' do
    sign_out
    login_second_user
    click_link 'Details'
    select_date
    sign_out
    login
    click_link 'View Requests'
    click_button 'Reject'
    sign_out
    login_second_user
    click_link 'Details'
    expect(page).to have_select('date', :with_options => [(Time.now).day+1])
  end

  scenario 'once a request has been rejected, the date on the calendar should not be yellow' do
    sign_out
    login_second_user
    click_link 'Details'
    select_date
    sign_out
    login
    click_link 'View Requests'
    click_button 'Reject'
    sign_out
    login_second_user
    click_link 'Details'
    expect(page).not_to have_css '.requested'
    expect(page).not_to have_css '.booked'
  end

  scenario 'a user cannot select a date in the past' do
    sign_out
    login_second_user
    click_link 'Details'
    expect(page).not_to have_select('date', :with_options => [(Time.now).day-1])
  end

  scenario 'dates in the past will be greyed out' do
    find(:css, '.arrow.left').click
    expect(page).to have_css '.unavailable'
  end

  scenario 'dates in the future will not be greyed out' do
    select ('October'), :from => "month"
    select ((Time.now).year+1).to_s, :from => "year"
    click_button 'Go'
    expect(page).not_to have_css '.unavailable'
  end
  
  scenario 'Clicking the back button takes them back to the homepage' do
    click_button 'Back'
    expect(current_path).to eq '/'
  end
end