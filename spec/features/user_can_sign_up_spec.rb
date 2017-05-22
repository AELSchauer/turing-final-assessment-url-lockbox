require 'rails_helper'

feature 'User can register for an account' do
  it 'through the registration form' do
    user = build(:user)

    visit root_path

    expect(current_path).to eq(login_path)

    click_on 'Sign up here!'

    expect(current_path).to eq(register_path)

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
    click_on 'Submit'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome: #{user.email}")
  end

  context 'errors' do
    it 'but an error returns email is left blank' do
      user = create(:user)

      visit register_path

      fill_in 'user[email]', with: ""
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
      click_on 'Submit'

      expect(current_path).to eq(register_path)
      binding.pry
      expect(page).to have_content("Email can't be blank.")
    end

    it 'but an error returns if an email is already taken' do
      user = create(:user)

      visit register_path

      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
      click_on 'Submit'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Email already taken.")
    end

    it 'but an error returns if the password is blank' do
      user = create(:user)

      visit register_path

      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: user.password
      click_on 'Submit'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password can't be blank.")
      expect(page).to have_content("Password confirmation can't be blank.")
    end

    it 'but an error returns if the password does not match the confirmation' do
      user = create(:user)

      visit register_path

      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      fill_in 'user[password_confirmation]', with: "bad confirmation"
      click_on 'Submit'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match password.")
    end
  end
end