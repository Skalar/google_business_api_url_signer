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
  its(:signed_url) { should eq signed_url }

  it "ensures that the URL contains a client id" do
    expect {
      described_class.new(url: '', private_key: private_key).signature
    }.to raise_error GoogleBusinessApiUrlSigner::MissingClientIdError
  end

  it "ensures that no signature exists within the URL" do
    expect {
      described_class.new(url: signed_url, private_key: private_key).signature
    }.to raise_error GoogleBusinessApiUrlSigner::UrlAlreadySignedError
  end

  it "ensures that private key is set" do
    expect {
      described_class.new(url: signed_url, private_key: '').signature
    }.to raise_error GoogleBusinessApiUrlSigner::MissingPrivateKeyError
  end


  describe "default private key" do
    after { described_class.default_private_key = nil }

    it "uses default private key when set" do
      described_class.default_private_key = 'default'

      Base64.should_receive(:decode64).with('default').and_return 'decoded'
      described_class.new(url: url).signature
    end

    it "uses the private key when options are filled with a blank private key" do
      described_class.default_private_key = 'default'

      Base64.should_receive(:decode64).with('default').and_return 'decoded'
      described_class.new(url: url, private_key: nil).signature
    end
  end
end
