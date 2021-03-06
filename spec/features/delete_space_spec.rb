require_relative 'web_helpers'

feature 'delete' do
  scenario 'user can see the delete button on their own space' do
    login
    add_space
    click_link 'Details'
    expect(page).to have_content 'Delete'
  end

  scenario 'user cannot see the delete button if they dont own the space' do
    login
    add_space
    sign_out
    login_second_user
    visit '/'
    click_link 'Details'
    expect(page).not_to have_content 'Delete'
  end

  scenario 'user can delete their space' do
    login
    add_space
    click_link 'Details'
    click_link 'Delete'
    expect(current_path).to eq '/'
    expect(page).not_to have_content 'this is a space you would like to stay in'
  end

end
