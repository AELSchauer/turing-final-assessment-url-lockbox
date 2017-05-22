require 'rails_helper'

describe "Links API", type: :request do
  describe 'for an authenticated user' do
    let(:user) { create(:user) }

    before(:each) do
      post login_path, params: { login: { email: user.email, password: user.password } }
    end

    after(:each) do
      delete logout_path
    end

    it "returns a list of links" do
      owned_links = create_list(:link, 3, user: user)
      unowned_links = create_list(:link, 3)

      get "/api/v1/links"

      expect(response).to be_success

      links = JSON.parse(response.body)

      expect(links.count).to eq(3)
      expect(Link.count).to eq(6)
    end
  end

  describe 'for an unauthenticated user' do
    it 'returns an empty array' do
      get "/api/v1/links"

      expect(response.status).to eq(404)

      body = JSON.parse(response.body)

      expect(body['error']).to eq('Unauthenticated user')
    end
  end
end
