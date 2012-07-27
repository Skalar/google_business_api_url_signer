require 'base64'
require 'openssl'

module GoogleBusinessApiUrlSigner
  # Public: Takes care of signing URLs
  #
  # Google's documentation for this can be found here:
  # https://developers.google.com/maps/documentation/business/webservices#generating_valid_signatures
  #
  class Signer
    BASE_64_DECODE_ENCODE_REPLACEMENTS = ['-_', '+/']

    cattr_accessor :default_private_key
    self.default_private_key = ''

    attr_reader :url

    # Public: Initializes the signer
    #
    # options   - url must be given within the options,
    #             private_key can be given, or you can set default value with:
    #             GoogleBusinessApiUrlSigner::Signer.default_private_key = 'key'
    #
    def initialize(options = {})
      @url = options.fetch :url
      @private_key = options.fetch :private_key, default_private_key
      @private_key = default_private_key if @private_key.blank?
    end

    def private_key
      return @private_key if @private_key.present?
      fail MissingPrivateKeyError
    end

    # Public: Calculates the signature from the given URL and private key
    def signature
      Base64.encode64(signature_digest).tr(*BASE_64_DECODE_ENCODE_REPLACEMENTS.reverse).chomp
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
      Base64.decode64 private_key.tr(*BASE_64_DECODE_ENCODE_REPLACEMENTS)
    end
  end
end
