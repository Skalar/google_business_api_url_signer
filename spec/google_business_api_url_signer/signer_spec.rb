require 'spec_helper'

describe GoogleBusinessApiUrlSigner::Signer do
  let(:url) { "http://maps.googleapis.com/maps/api/geocode/json?address=New+York&sensor=false&client=clientID" }
  let(:private_key) { "vNIXE0xscrmjlyV-12Nj_BvUPaw=" }
  let(:signature) { "KrU1TzVQM7Ur0i8i7K3huiw3MsA=" }
  let(:signed_url) { "http://maps.googleapis.com/maps/api/geocode/json?address=New+York&sensor=false&client=clientID&signature=#{signature}" }

  subject do
    described_class.new(
      url: url,
      private_key: private_key
    )
  end

  its(:url) { should eq url }
  its(:private_key) { should eq private_key }
  its(:signature) { should eq signature }
end
