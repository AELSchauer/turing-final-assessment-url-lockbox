require 'rails_helper'

feature 'User can logout of their account' do
  it '' do
    user = create(:user)
    visit login_path
    fill_in 'login[email]', with: user.email
    fill_in 'login[password]', with: user.password
    click_on 'Submit'

    click_on 'Logout'

    expect(current_path).to eq(login_path)
    expect(page).to have_content('Login')
    expect(page).to have_content('Logout successful.')
  end
end
