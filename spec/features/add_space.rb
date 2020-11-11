require_relative 'web_helpers'

feature 'add_space' do
  scenario 'allows a user to add a space' do
    add_space
    expect(page).to have_content('stay in')
  end

   scenario 'allows users to go back to the home page if they decide not to add a space' do
    visit '/spaces/new'
    click_button 'back'
    expect(page).to have_content 'Homepage'
   end
end
