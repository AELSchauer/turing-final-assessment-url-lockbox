require 'rails_helper'

feature 'User can create a link', type: :feature, js: true do
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

  it 'through the new link form on the links index page' do
    visit root_path
    link = build(:link)

    fill_in 'link[url]', with: link.url
    fill_in 'link[title]', with: link.title
    click_on 'Add Link'

    within('.link') do
      expect(page).to have_content("Title: #{link.title}")
      expect(page).to have_content("URL: #{link.url}")
      expect(page).to have_content('Read?: false')
      # expect(page).to have a button to mark as unread
      # expect(page).to have a button to mark as read
    end
  end

  context 'errors' do
    it 'returns an error if title field is blank' do
      visit root_path
      link = build(:link)

      fill_in 'link[url]', with: link.url
      fill_in 'link[title]', with: ''
      click_on 'Add Link'

      within('#form-errors') do
        expect(page).to have_content("Title can't be blank.")
      end
    end

    it 'returns an error if url field is blank' do
      visit root_path
      link = build(:link)

      fill_in 'link[url]', with: ''
      fill_in 'link[title]', with: link.title
      click_on 'Add Link'

      within('#form-errors') do
        expect(page).to have_content("Url can't be blank.")
      end
    end

    it 'returns an error if url is invalid' do
      visit root_path
      link = build(:link)

      fill_in 'link[url]', with: 'google.com'
      fill_in 'link[title]', with: link.title
      click_on 'Add Link'

      within('#form-errors') do
        expect(page).to have_content('Url is invalid.')
      end
    end
  end
end
