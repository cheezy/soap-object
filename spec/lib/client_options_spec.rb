require 'spec_helper'

class TestSoapObjectWithProperties
  include SoapObject

  wsdl 'http://blah.com'
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

describe SoapObject do
  let(:client) { double('client') }
  let(:platform) {double('savon')}

  before do
    allow(platform).to receive(:client).and_return(client)
  end

  context 'when creating new instances' do

    it 'should know when it is connected to service' do
      subject = TestSoapObjectWithProperties.new(platform)

      expect(subject).to be_connected
    end

    it 'should initialize the client using the wsdl' do
      expect(platform).to receive(:client).with(hash_including(wsdl: 'http://blah.com'))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should allow one to setup a proxy' do
      expect(platform).to receive(:client).with(hash_including(proxy: 'http://proxy.com:8080'))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should allow one to set an open timeout' do
      expect(platform).to receive(:client).with(hash_including(open_timeout: 10))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should allow one to set a read timeout' do
      expect(platform).to receive(:client).with(hash_including(read_timeout: 20))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should allow one to set a soap header' do
      expect(platform).to receive(:client).with(hash_including(soap_header: {'Token' => 'secret'}))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should allow one to set the encoding' do
      expect(platform).to receive(:client).with(hash_including(encoding: 'UTF-16'))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should allow one to use basic authentication' do
      expect(platform).to receive(:client).with(hash_including(basic_auth: ['steve', 'secret']))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should allow one to use digest authentication' do
      expect(platform).to receive(:client).with(hash_including(digest_auth: ['digest', 'auth']))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should enable logging when logging level set' do
      expect(platform).to receive(:client).with(hash_including(log: true))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should allow one to set the log level' do
      expect(platform).to receive(:client).with(hash_including(log_level: :error))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should use pretty format for xml when logging' do
      expect(platform).to receive(:client).with(hash_including(pretty_print_xml: true))

      TestSoapObjectWithProperties.new(platform)
    end

    it 'should allow one to set the soap version' do
      expect(platform).to receive(:client).with(hash_including(soap_version: 2))

      TestSoapObjectWithProperties.new(platform)
    end

  end

  context 'when creating new instances with out client property overrides' do

    it 'should set SSL version to 3 by default' do
      expect(platform).to receive(:client).with(hash_including(ssl_version: :SSLv3))

      WithoutClientProperties.new(platform)
    end

    it 'should disable SSL verification by default' do
      expect(platform).to receive(:client).with(hash_including(ssl_verify_mode: :none))

      WithoutClientProperties.new(platform)
    end

    it 'should disable logging by default' do
      expect(platform).to receive(:client).with(hash_including(log: false))

      WithoutClientProperties.new(platform)
    end
  end
end
