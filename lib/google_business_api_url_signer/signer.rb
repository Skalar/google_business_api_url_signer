require 'base64'
require 'openssl'

module GoogleBusinessApiUrlSigner
  class Signer
    attr_reader :url, :private_key

    # Public: Initializes the signer
    #
    # options   - Both url and private_key must be given within the options
    #
    def initialize(options = {})
      @url = options.fetch :url
      @private_key = options.fetch :private_key
    end


    # Public: Calculates the signature from the given URL and private key
    def signature
      Base64.encode64(signature_digest).tr('+/', '-_').chomp
    end

    # Public: Calculates the signature and returns a signed version of the URL
    def signed_url
      [
        parsed_url.scheme,
        '://',
        parsed_url.host,
        parsed_url.path,
        '?',
        query_params_as_string_with_signature
      ].join
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
      @parsed_url ||= URI(url)
    end

    def path_and_query
      [parsed_url.path, query_params_as_string].join '?'
    end



    def query_params
      return @query_params if @query_params

      @query_params = Hash[(parsed_url.query || '').split('&').collect { |key_value| key_value.split('=')}]

      fail MissingClientIdError if @query_params['client'].blank?
      fail UrlAlreadySignedError if @query_params['signature'].present?

      @query_params
    end

    def query_params_as_string(params = nil)
      (params || query_params).to_a.collect { |pair| pair.join('=') }.join('&')
    end

    def query_params_as_string_with_signature
      query_params_as_string(
        query_params.update(signature: signature)
      )
    end



    def private_key_decoded
      Base64.decode64 private_key.tr('-_', '+/')
    end
  end
end
