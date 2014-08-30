# Google Business Api Url Signer

Signs URLs used to call Google's business APIs.

[![Build Status](https://travis-ci.org/Skalar/google_business_api_url_signer.svg?branch=master)](https://travis-ci.org/Skalar/google_business_api_url_signer)

## Installation

Add this line to your application's Gemfile:

    gem 'google_business_api_url_signer', git: 'git://github.com/Skalar/google_business_api_url_signer.git'


And then execute:

    $ bundle

## Usage

    private_key = "my-private-key-here"
    url = "http://maps.googleapis.com/maps/api/geocode/json?address=New+York&sensor=false&client=clientID"
    GoogleBusinessApiUrlSigner.add_signature(url, private_key)
    => "http://maps.googleapis.com/maps/api/geocode/json?address=New+York&sensor=false&client=clientID&signature=KrU1TzVQM7Ur0i8i7K3huiw3MsA="


The private key may also be set as a default value on the Signer class,
in which case you don't have to give it when calling `add_signature`.

    GoogleBusinessApiUrlSigner::Signer.default_private_key = 'my-default-private-key-here'


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
