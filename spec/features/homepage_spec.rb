require_relative 'web_helpers'

feature 'homepage' do
  before [:each] do
    login
  end 
    scenario 'opens profile page' do
      click_link 'Profile'
      expect(page).to have_content 'User Profile'
      expect(current_path).to include '/user'
    end 
    scenario 'opens add new space page' do
      click_link 'Add New Space'
      expect(page).to have_content 'Add a New Space'
      expect(current_path).to eq '/spaces/new'
    end
    scenario 'opens view requests page' do
        click_link 'View Requests'
        expect(page).to have_content 'Requests'
        expect(current_path).to eq '/reservation-requests'
    end
    scenario 'open reservations page' do
        click_link 'View Reservations'
        expect(page).to have_content 'My Trips'
        expect(current_path).to eq '/reservations'
    end
    scenario 'Opens space details' do
        add_space
        click_link 'Details'
        expect(page).to have_content 'Price: £10 per night'
        expect(current_path).to include '/spaces'
    end
end