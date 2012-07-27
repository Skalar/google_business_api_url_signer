module GoogleBusinessApiUrlSigner
  class Error < StandardError; end

  class MissingPrivateKeyError < Error; end
  class MissingClientIdError < Error; end
  class UrlAlreadySignedError < Error; end
end
