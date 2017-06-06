require 'rails_helper'

feature 'User can mark a link as read or unread', type: :feature, js: true do
  let(:user_1) { create(:user) }
  let(:user_2) { create(:user) }
  let(:link_a) { build(:link) }
  let(:link_b) { build(:link) }

  before(:each) do
    visit login_path
    fill_in 'login[email]', with: user_1.email
    fill_in 'login[password]', with: user_1.password
    click_on 'Submit'
  end

  after(:each) do
    visit root_path
    click_on 'Logout'
  end

  it 'and the page will display the top link' do
    link_1a = create(:link, title: link_a.title, url: link_a.url, user: user_1)
    link_2a = create(:link, title: link_a.title, url: link_a.url, user: user_2, read: true)

    link_1b = create(:link, title: link_b.title, url: link_b.url, user: user_1)


    visit root_path

    within("#link-#{link_1b.id}") do
      click_on 'Mark As Read'
    end

    within("#link-#{link_1b.id}") do
      expect(page).to have_button('Mark As Unread')
    end

    within("#link-#{link_1a.id}") do
      expect(page).to have_button('Mark As Read')
    end

    within("#link-#{link_1a.id}") do
      click_on 'Mark As Read'
    end

    within("#link-#{link_1a.id}") do
      expect(page).to have_button('Mark As Unread')
    end

    within("#link-#{link_1b.id}") do
      expect(page).to have_button('Mark As Unread')
    end
  end
end
