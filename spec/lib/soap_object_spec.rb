require 'spec_helper'

class TestServiceWithWsdl
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
end

class TestWorld
  include SoapObject::Factory
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

    it "should allow one to set the encoding" do
      subject.send(:client_properties)[:encoding].should == 'UTF-16'
    end

    it "should allow one to use basic authentication" do
      subject.send(:client_properties)[:basic_auth].should == ['steve', 'secret']
    end

    it "should allow one to use digest authentication" do
      subject.send(:client_properties)[:digest_auth].should == ['digest', 'auth']
    end

    it "should allow one to set the log level" do
      subject.send(:client_properties)[:log_level].should == :error
    end
  end

  context "when using the factory to create to service" do
    let(:world) { TestWorld.new }

    it "should create a valid service object" do
      service = world.using(TestServiceWithWsdl)
      service.should be_instance_of TestServiceWithWsdl
    end

    it "should create a valid service and invoke a block" do
      world.using(TestServiceWithWsdl) do |service|
        service.should be_instance_of TestServiceWithWsdl
      end
    end

    it "should create the service the first time we use it" do
      obj = TestServiceWithWsdl.new
      TestServiceWithWsdl.should_receive(:new).once.and_return(obj)
      world.using(TestServiceWithWsdl)
      world.using(TestServiceWithWsdl)
    end
  end

  context "when calling methods on the service" do
    before do
      Savon.should_receive(:client).and_return(client)
    end

    it "should make a valid request" do
      response = double('response')
      response.should_receive(:to_xml)
      client.should_receive(:call).with(:fake_call, message: {data_key: 'some_value'}).and_return(response)
      @so = TestServiceWithWsdl.new
      @so.fake_call data_key: 'some_value'
    end
  end
end
