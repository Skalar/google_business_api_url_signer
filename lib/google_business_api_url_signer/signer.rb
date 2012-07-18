require 'base64'
require 'openssl'

module GoogleBusinessApiUrlSigner
  class Signer
    attr_reader :url, :private_key

    def initialize(options = {})
      @url = options.fetch :url
      @private_key = options.fetch :private_key
    end

    def signature
      Base64.encode64(signature_digest).tr('+/','-_').chomp
    end


    private

    def signature_digest
      OpenSSL::HMAC.digest(
        OpenSSL::Digest.new('sha1'),
        private_key_decoded, 
        path_and_query
      )
    end

    def parsed_url
      URI(url)
    end

    def path_and_query
      [parsed_url.path, parsed_url.query].join '?'
    end

    def private_key_decoded
      Base64.decode64 private_key.tr('-_','+/')
    end
  end
end
