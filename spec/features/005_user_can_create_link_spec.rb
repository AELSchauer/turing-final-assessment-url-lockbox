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
      expect(page).to have_button('Mark As Read')
      expect(page).to have_button('Edit')
    end
  end

  it 'immediately after creating a first link' do
    link_1 = build(:link)
    link_2 = build(:link)

    visit root_path

    fill_in 'link[url]', with: link_1.url
    fill_in 'link[title]', with: link_1.title
    click_on 'Add Link'

    fill_in 'link[url]', with: link_2.url
    fill_in 'link[title]', with: link_2.title
    click_on 'Add Link'

    expect(page).to have_selector('.link', count: 2)
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
