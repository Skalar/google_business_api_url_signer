require "google_business_api_url_signer/version"
require "google_business_api_url_signer/signer"

module GoogleBusinessApiUrlSigner
  def add_signature(url)
    Signer.new(url: url).signed_url
  end

  extend self
end
