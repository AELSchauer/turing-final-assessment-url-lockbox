require 'rails_helper'

feature 'User can filter links by text', type: :feature, js: true do
  let(:user) { create(:user) }

  before(:each) do
    Capybara.ignore_hidden_elements = false

    visit login_path
    fill_in 'login[email]', with: user.email
    fill_in 'login[password]', with: user.password
    click_on 'Submit'
  end

  after(:each) do
    visit root_path
    click_on 'Logout'

    Capybara.ignore_hidden_elements = true
  end

  it 'and the page will only unread links' do
    link_1 = create(:link, user: user, read: true)
    link_2 = create(:link, user: user, title: 'Robot', url: 'https://en.wikipedia.org/wiki/robot')
    link_3 = create(:link, user: user, title: 'Zero', url: 'https://en.wikipedia.org/wiki/0')

    visit root_path

    click_button 'Show Unread Links'
    click_button 'Show Unread Links'

    expect(find("#link-#{link_1.id}").visible?).to eq(false)
    expect(find("#link-#{link_2.id}").visible?).to eq(true)
    expect(find("#link-#{link_3.id}").visible?).to eq(true)
  end

  it 'and the page will only read links' do
    link_1 = create(:link, user: user, read: true)
    link_2 = create(:link, user: user, title: 'Robot', url: 'https://en.wikipedia.org/wiki/robot')
    link_3 = create(:link, user: user, title: 'Zero', url: 'https://en.wikipedia.org/wiki/0')

    visit root_path

    click_button 'Show Read Links'
    click_button 'Show Read Links'

    expect(find("#link-#{link_1.id}").visible?).to eq(true)
    expect(find("#link-#{link_2.id}").visible?).to eq(false)
    expect(find("#link-#{link_3.id}").visible?).to eq(false)
  end
end
