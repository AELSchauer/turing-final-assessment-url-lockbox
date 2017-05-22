require 'rails_helper'

feature 'User can register for an account' do
  it 'through the registration form' do
    user = build(:user)

    visit root_path

    click_on 'Sign Up'

    expect(current_path).to eq(register_path)

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
    click_on 'Submit'

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome: #{user.email}")
  end

  it 'but an error returns if an email is already taken' do
    user = create(:user)

    visit register_path

    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    fill_in 'user[password_confirmation]', with: user.password
    click_on 'Submit'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Sorry, but that email has already been taken.")
  end
end