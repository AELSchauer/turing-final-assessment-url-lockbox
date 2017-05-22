require 'rails_helper'

feature 'User can view their links', type: :feature, js: true do
  let(:user) { create(:user) }
  let(:owned_links) { create_list(:link, 3, user: user) }
  let(:unowned_links) { create_list(:link, 3) }

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

  it 'on the links index page' do
    expect(current_path).to eq(root_path)
    wait_for_ajax
    p page.html
    owned_links.each do |link|
      within("#link-box-#{link.id}") do
        expect(page).to have_content(link.title)
        expect(page).to have_content(link.url)
        expect(page).to have_content('Read?: false')
        # expect(page).to have a button to mark as unread
        # expect(page).to have a button to mark as read
      end
    end
  end
end