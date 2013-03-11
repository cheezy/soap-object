require 'spec_helper'

class TestServiceWithWsdl
  include SoapObject

  wsdl 'http://blah.com'
  proxy 'http://proxy.com:8080'
  open_timeout 10
  read_timeout 20
  soap_header 'Token' => 'secret'
end


describe SoapObject do
  let(:client) { double('client') }
  let(:subject) { TestServiceWithWsdl.new }


  context "when creating new instances" do
    before do 
      Savon.should_receive(:client).and_return(client)
    end
  
    it "should initialize the client using the wsdl" do
      subject.send(:client_properties)[:wsdl].should == 'http://blah.com'
    end

    it "should know when it is connected to service" do
      subject.should be_connected
    end

    it "should allow one to setup a proxy" do
      subject.send(:client_properties)[:proxy].should == 'http://proxy.com:8080'
    end

    it "should allow one to set an open timeout" do
      subject.send(:client_properties)[:open_timeout].should == 10
    end

    it "should allow one to set a read timeout" do
      subject.send(:client_properties)[:read_timeout].should == 20
    end

    it "should allow one to set a soap header" do
      subject.send(:client_properties)[:soap_header].should == {'Token' => 'secret'}
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
