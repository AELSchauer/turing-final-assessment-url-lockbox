require 'rails_helper'

describe 'Links API', type: :request do
  describe 'for an authenticated user' do
    let(:user) { create(:user) }

    before(:each) do
      post login_path, params: { login: { email: user.email, password: user.password } }
    end

    after(:each) do
      delete logout_path
    end

    it 'returns a list of links' do
      create_list(:link, 3, user: user)
      create_list(:link, 3)

      get '/api/v1/links'

      expect(response).to be_success

      links = JSON.parse(response.body)

      expect(links.count).to eq(3)
      expect(Link.count).to eq(6)
    end

    it 'returns a link for a post request' do
      link = build(:link)

      post '/api/v1/links/', params: { link: { title: link.title, url: link.url } }

      body = JSON.parse(response.body)

      expect(body['title']).to eq(link.title)
      expect(body['url']).to eq(link.url)
    end

    it 'returns a link for a put request' do
      existing_link = create(:link, user: user)
      link = build(:link)

      put "/api/v1/links/#{existing_link.id}", params: { link: { title: link.title, url: link.url } }

      body = JSON.parse(response.body)

      expect(body['title']).to eq(link.title)
      expect(body['url']).to eq(link.url)
    end

    it 'returns a 401 for an bad post request' do
      post '/api/v1/links', params: { link: { title: '', url: 'google.com' } }

      expect(response.status).to eq(400)

      body = JSON.parse(response.body)

      expect(body['error'].count).to eq(2)
    end

    it 'returns a 401 for a bad put request' do
      existing_link = create(:link, user: user)
      link = build(:link)

      put "/api/v1/links/#{existing_link.id}", params: { link: { title: '', url: 'google.com' } }

      expect(response.status).to eq(400)

      body = JSON.parse(response.body)

      expect(body['error'].count).to eq(2)
    end
  end

  describe 'for an unauthenticated user' do
    it 'returns a 401 for a get request' do
      get '/api/v1/links'

      expect(response.status).to eq(401)

      body = JSON.parse(response.body)

      expect(body['error']).to eq('Unauthorized request')
    end

    it 'returns a 401 for an unauthorized post request' do
      link = build(:link)

      post '/api/v1/links', params: { link: { title: link.title, url: link.url } }

      expect(response.status).to eq(401)

      body = JSON.parse(response.body)

      expect(body['error']).to eq('Unauthorized request')
    end

    it 'returns a 401 for an unauthorized put request' do
      existing_link = create(:link)
      link = build(:link)

      put "/api/v1/links/#{existing_link.id}", params: { link: { title: link.title, url: link.url } }

      expect(response.status).to eq(401)

      body = JSON.parse(response.body)

      expect(body['error']).to eq('Unauthorized request')
    end
  end
end
