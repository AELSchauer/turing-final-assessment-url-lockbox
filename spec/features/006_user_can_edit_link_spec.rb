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
    link = create(:link, user: user)
    url = 'http://robohash.org/my-own-slug-1.png'
    title = 'my-own-slug-1'

    visit root_path

    within("#link-#{link.id}") do
      click_link 'Edit'
    end

    fill_in 'link[url]', with: url
    fill_in 'link[title]', with: title
    click_on 'Edit Link'

    within('.link') do
      expect(page).to have_content("Title: #{title}")
      expect(page).to have_content("URL: #{url}")
    end
  end

  context 'errors' do
    it 'returns an error if title field is blank' do
      link = create(:link, user: user)

      visit edit_link_path(link)

      fill_in 'link[url]', with: link.url
      fill_in 'link[title]', with: ''
      click_on 'Edit Link'

      within('#form-errors') do
        expect(page).to have_content("Title can't be blank.")
      end
    end

    it 'returns an error if url field is blank' do
      link = create(:link, user: user)

      visit edit_link_path(link)

      fill_in 'link[url]', with: ''
      fill_in 'link[title]', with: link.title
      click_on 'Edit Link'

      within('#form-errors') do
        expect(page).to have_content("Url can't be blank.")
      end
    end

    it 'returns an error if url is invalid' do
      link = create(:link, user: user)

      visit edit_link_path(link)

      fill_in 'link[url]', with: 'google.com'
      fill_in 'link[title]', with: link.title
      click_on 'Edit Link'

      within('#form-errors') do
        expect(page).to have_content('Url is invalid.')
      end
    end
  end
end
