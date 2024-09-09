# app/models/geolocation.rb

class Geolocation < ApplicationRecord
  validates :ip_address, presence: true, uniqueness: true
  validates :url, presence: true, if: :ip_blank?
  validates :url, format: {
    allow_blank: true,
    with: /\A[^\s]+\z/,
    message: 'must be a valid URL'
  }

  def ip_blank?
    ip_address.blank?
  end
end
