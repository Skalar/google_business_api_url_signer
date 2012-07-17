require 'spec_helper'

describe GoogleBusinessApiUrlSigner do
  describe ".add_signature" do
    let(:signer) { mock }
    let(:url) { "http://maps.googleapis.com/maps/api/geocode/json?address=New+York&sensor=false&client=clientID" }
    let(:signed_url) { "http://maps.googleapis.com/maps/api/geocode/json?address=New+York&sensor=false&client=clientID&signature=KrU1TzVQM7Ur0i8i7K3huiw3MsA=" }

    it "delegates to signer" do
      GoogleBusinessApiUrlSigner::Signer.should_receive(:new).with(hash_including(url: url)).and_return signer
      signer.should_receive(:signed_url).and_return signed_url

      described_class.add_signature(url).should eq signed_url
    end
  end
end
