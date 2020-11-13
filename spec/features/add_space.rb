require_relative 'web_helpers'

feature 'add_space' do

  before [:each] do
    login
  end
  
  scenario 'allows a user to add a space' do
    add_space
    expect(page).to have_content('stay in')
    expect(current_path).to eq '/'
  end

   scenario 'allows users to go back to the home page if they decide not to add a space' do
    visit '/spaces/new'
    click_button 'back'
    expect(page).to have_content 'Homepage'
   end

   scenario 'if the user doesnt fill in all of the fields, the space isnt added and the user is redirected back to the add page' do               
    add_incomplete_space
    expect(current_path).to eq '/spaces/new'
    expect(page).to have_content 'Problem creating space'
    expect(page).to have_field('name', with: '') 
    expect(page).to have_field('price', with: '10') 
    expect(page).to have_field('description', with: 'this is a space you would like to stay in') 
   end
end