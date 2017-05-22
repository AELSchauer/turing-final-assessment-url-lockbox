class Link < ApplicationRecord
  belongs_to :user
  validates :title, :url, presence: true
  before_validation :url_valid?

  def url_valid?
    return false if url.nil? || url.empty?
    uri = URI.parse(url)
    errors.add :url, 'is invalid' if !uri.is_a?(URI::HTTP) || uri.host.nil?
  end
end
