require 'spec_helper'

class WithSslOptions
  include SoapObject

  ssl_options do |opts|
    opts.verify_mode = :peer
    opts.version = :SSLv2
  end

end

describe SoapObject do
  let(:client) { double('client') }
  let(:platform) {double('savon')}

  before do
    allow(platform).to receive(:client).and_return(client)
  end

  context 'when setting client ssl options' do

    it 'should allow one to enable SSL verification' do
      expect(platform).to receive(:client).with(hash_including(ssl_verify_mode: :peer))

      WithSslOptions.new(platform)
    end

    it 'should allow one to set SSL version' do
      expect(platform).to receive(:client).with(hash_including(ssl_version: :SSLv2))

      WithSslOptions.new(platform)
    end
  end


end
