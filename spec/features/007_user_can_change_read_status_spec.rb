require 'rails_helper'

feature 'User can mark a link as read or unread', type: :feature, js: true do
  let(:user) { create(:user) }

  before(:each) do
    visit login_path
    fill_in 'login[email]', with: user.email
    fill_in 'login[password]', with: user.password
    click_on 'Submit'
  end

  after(:each) do
    visit root_path
    click_on 'Logout'
  end

  it 'and the page will display the top link' do
    link_1 = create(:link, user: user)
    link_2 = create(:link, user: user)

    visit root_path

    within("#link-#{link_2.id}") do
      click_on 'Mark As Read'
    end

    within("#link-#{link_2.id}") do
      expect(page).to have_button('Mark As Unread')
    end

    within("#link-#{link_1.id}") do
      expect(page).to have_button('Mark As Read')
    end

    within("#link-#{link_1.id}") do
      click_on 'Mark As Read'
    end

    within("#link-#{link_1.id}") do
      expect(page).to have_button('Mark As Unread')
    end

    within("#link-#{link_2.id}") do
      expect(page).to have_button('Mark As Unread')
    end
  end
end
