require 'active_support/all'
require "google_business_api_url_signer/version"
require "google_business_api_url_signer/errors"
require "google_business_api_url_signer/signer"

module GoogleBusinessApiUrlSigner
  # Public: Adds a signature to given URL
  #
  # url   - The Google API URL you want to sign.
  #         The URL should contain your Google client ID set as get parameter 'client'
  #
  #
  # Example
  #
  #   url = "http://maps.googleapis.com/maps/api/geocode/json?address=New+York&sensor=false&client=clientID"
  #   GoogleBusinessApiUrlSigner.add_signature(url)
  #   # => "http://maps.googleapis.com/maps/api/geocode/json?address=New+York&sensor=false&client=clientID&signature=KrU1TzVQM7Ur0i8i7K3huiw3MsA="
  #
  def add_signature(url)
    Signer.new(url: url).signed_url
  end

  extend self
end
