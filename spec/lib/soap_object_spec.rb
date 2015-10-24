require 'spec_helper'

class WithoutClientProperties
  include SoapObject
end

describe SoapObject do

  context 'when calling methods on the service' do
    let(:response) { double('response') }
    let(:client) { double('client') }
    let(:platform) {double('savon')}
    let(:subject) { WithoutClientProperties.new(platform) }

    before do
      expect(platform).to receive(:client).and_return(client)
      expect(response).to receive(:to_xml)
    end

    it 'should make a valid request' do
      expect(client).to receive(:call).with(:fake_call, message: {data_key: 'some_value'}).and_return(response)
      subject.fake_call data_key: 'some_value'
    end

    it 'should make a valid request with custom xml' do
      expected_xml = '<xml><envelope/><data></data></envelope></xml>'
      expect(client).to receive(:call).with(anything, xml: expected_xml).and_return(response)
      subject.fake_call expected_xml
    end
  end
end
