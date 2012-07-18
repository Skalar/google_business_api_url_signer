module GoogleBusinessApiUrlSigner
  class Error < StandardError; end

  class MissingClientIdError < Error; end
  class UrlAlreadySignedError < Error; end
end
