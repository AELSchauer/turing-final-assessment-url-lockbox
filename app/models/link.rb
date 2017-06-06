class Link < ApplicationRecord
  belongs_to :user
  validates :title, :url, presence: true
  before_validation :url_valid?
  after_create :send_to_hot_read
  after_validation :hot

  attr_reader :hot

  def url_valid?
    return false if url.nil? || url.empty?
    uri = URI.parse(url)
    errors.add :url, 'is invalid' if !uri.is_a?(URI::HTTP) || uri.host.nil?
  end

  def hot
    response = HTTParty.get("#{ENV['HOT_READS_URL']}/api/v1/hot_reads?address=#{url}")
    @hot = response['rank']
  end

  def send_to_hot_read
    query = { url:  { address: url } }
    query.merge!({ read: { user_id: user.id } }) if read
    response = HTTParty.post(
      "#{ENV['HOT_READS_URL']}/api/v1/read_urls",
      query: query
    )
  end
end
