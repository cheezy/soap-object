require 'spec_helper'

class TestSoapObject
  include SoapObject
  
  wsdl 'http://blah.com'
end

class TestWorld
  include SoapObject::Factory
end

describe 'SoapObject factory' do
  context "when using the factory to create to service" do
    let(:world) { TestWorld.new }

    it "should create a valid service object" do
      service = world.using(TestSoapObject)
      expect(service).to be_instance_of TestSoapObject
    end

    it "should create a valid service and invoke a block" do
      world.using(TestSoapObject) do |service|
        expect(service).to be_instance_of TestSoapObject
      end
    end

    it "should create the service the first time we use it" do
      obj = TestSoapObject.new
      expect(TestSoapObject).to receive(:new).once.and_return(obj)
      world.using(TestSoapObject)
      world.using(TestSoapObject)
    end
  end
end