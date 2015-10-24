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

  before do
    allow(Savon).to receive(:client).and_return(client)
  end

  context 'when setting client ssl options' do
    let(:subject) { WithSslOptions.new }

    it 'should allow one to enable SSL verification' do
      expect(subject.send(:client_properties)[:ssl_verify_mode]).to eq(:peer)
    end

    it 'should allow one to set SSL version' do
      expect(subject.send(:client_properties)[:ssl_version]).to eq(:SSLv2)
    end
  end


end
