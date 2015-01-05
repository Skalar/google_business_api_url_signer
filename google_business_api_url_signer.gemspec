# -*- encoding: utf-8 -*-
require File.expand_path('../lib/google_business_api_url_signer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Thorbjørn Hermansen"]
  gem.email         = ["thhermansen@gmail.com"]
  gem.description   = %q{Signs URLs used to call Google's business APIs}
  gem.summary       = %q{Signs URLs used to call Google's business APIs}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "google_business_api_url_signer"
  gem.require_paths = ["lib"]
  gem.version       = GoogleBusinessApiUrlSigner::VERSION

  gem.add_dependency "activesupport", [">= 3.2.0", "~> 4.2.0"]
  gem.add_development_dependency "rspec", "3.1.0"
  gem.add_development_dependency "rake"
end
