require 'rails_helper'

feature 'User can login to their account' do
  it 'through the login form' do
    user = create(:user)

    visit root_path

    expect(current_path).to eq(login_path)

    fill_in 'login[email]', with: user.email
    fill_in 'login[password]', with: user.password
    click_on 'Submit'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Logout')
    expect(page).to have_content('Login successful.')
  end

  context 'errors' do
    it 'but an error returns email is left blank' do
      user = create(:user)

      visit login_path

      fill_in 'login[email]', with: ''
      fill_in 'login[password]', with: user.password
      click_on 'Submit'

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Email can't be blank.")
      expect(page).to have_content('Login unsuccessful.')
    end

    it 'but an error returns if the password is blank' do
      user = create(:user)

      visit login_path

      fill_in 'login[email]', with: user.email
      fill_in 'login[password]', with: ''
      click_on 'Submit'

      expect(current_path).to eq(login_path)
      expect(page).to have_content("Password can't be blank.")
      expect(page).to have_content('Login unsuccessful.')
    end

    it 'but an error returns if the credentials are invalid' do
      visit login_path

      fill_in 'login[email]', with: 'bad-email@email.com'
      fill_in 'login[password]', with: 'bad-password'
      click_on 'Submit'

      expect(current_path).to eq(login_path)
      expect(page).to have_content('Credentials are invalid.')
      expect(page).to have_content('Login unsuccessful.')
    end
  end
end
