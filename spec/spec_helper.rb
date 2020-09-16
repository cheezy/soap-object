# encoding: utf-8
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rspec'
require 'soap-object'

class TestWorld
  include SoapObject::Factory
end

class TestSoapObjectWithProperties
  include SoapObject

  wsdl 'http://blah.com'
  endpoint 'https://blah.com'
  proxy 'http://proxy.com:8080'
  open_timeout 10
  read_timeout 20
  soap_header 'Token' => 'secret'
  encoding 'UTF-16'
  basic_auth 'steve', 'secret'
  digest_auth 'digest', 'auth'
  log_level :error
  soap_version 2
end

class WithoutClientProperties
  include SoapObject
end

class TestSoapObject
  include SoapObject

  wsdl 'http://blah.com'
end

class WithSslOptions
  include SoapObject

  ssl_options do |opts|
    opts.verify_mode = :peer
    opts.version = :SSLv2
  end

end
