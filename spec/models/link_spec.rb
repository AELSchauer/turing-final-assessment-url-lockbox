require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:url) }
  it { should belong_to(:user) }

  it '#url_valid?' do
    link_1 = build(:link, url: 'google.com')
    link_2 = build(:link, url: '')
    link_3 = build(:link, url: 'http://ww.google.com')

    expect(link_1.valid?).to eq(false)
    expect(link_1.errors.full_messages[0]).to eq('Url is invalid')
    expect(link_2.valid?).to eq(false)
    expect(link_3.valid?).to eq(true)
  end
end
