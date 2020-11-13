require_relative 'web_helpers'

feature 'update space' do

  before [:each] do
    login
    add_space
  end
  scenario 'user can see the update button on their own space' do
    click_link 'Details'
    expect(page).to have_content 'Update'
  end

  scenario 'user cannot see the update button if they dont own the space' do
    sign_out
    login_second_user
    click_link 'Details'
    expect(page).not_to have_content 'Update'
  end

  scenario 'user can load their space with the current information' do
    click_link 'Details'
    click_link 'Update'
    expect(current_path).to include '/edit'
    expect(page).to have_field('description', with: 'this is a space you would like to stay in') 
  end

  scenario 'user can update their space' do
    click_link 'Details'
    click_link 'Update'
    update_space
    expect(current_path).to eq '/'
    expect(page).to have_content 'not a test space'
    expect(page).to have_content 'some may say that this has changed. They are correct'
    expect(page).to have_content '£4000'
  end

  scenario 'if a user updates their space but doesnt fill in all the infomration, they cannot advance' do
    click_link 'Details'
    click_link 'Update'
    incomplete_update_space
    expect(current_path).to include '/edit'
    expect(page).to have_field('name', with: 'test space') 
    expect(page).to have_field('price', with: '10') 
    expect(page).to have_field('description', with: 'this is a space you would like to stay in') 
    expect(page).to have_content 'There was a problem updating this space'
  end
 
  scenario 'user can go to update their space then go back to the homepage' do
    click_link 'Details'
    click_link 'Update'
    click_button 'Back'
    expect(current_path).to eq '/'
  end

end