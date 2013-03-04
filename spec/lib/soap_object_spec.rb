require 'spec_helper'

class TestServiceWithWsdl
  include SoapObject

  wsdl 'http://blah.com'
  proxy 'http://proxy.com:8080'
end


describe SoapObject do
  let(:client) { double('client') }

  context "when creating new instances" do
    before do 
      Savon.should_receive(:client).and_return(client)
    end
  
    it "should initialize the client using the wsdl" do
      subject = TestServiceWithWsdl.new
      subject.client_properties[:wsdl].should == 'http://blah.com'
    end

    it "should know when it is connected to service" do
      TestServiceWithWsdl.new.should be_connected
    end

    it "should allow one to setup a proxy" do
      subject = TestServiceWithWsdl.new
      subject.client_properties[:proxy].should == 'http://proxy.com:8080'
    end
  end

  context "when calling methods on the service" do
    before do
      Savon.should_receive(:client).and_return(client)
    end

    it "should make a valid request" do
      client.should_receive(:call).with(:fake_call, message: {data_key: 'some_value'})
      @so = TestServiceWithWsdl.new
      @so.stub(:body_for)
      @so.fake_call data_key: 'some_value'
    end
  end
end
