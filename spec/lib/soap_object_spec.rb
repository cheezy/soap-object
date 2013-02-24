require 'spec_helper'

class TestServiceWithWsdl
  include SoapObject

  wsdl 'http://blah.com'
end


describe SoapObject do
  
  context "when creating new instances with a wsdl" do
    it "should initialize the client using the wsdl" do
      Savon.should_receive(:client).with(wsdl: 'http://blah.com').and_return([])
      TestServiceWithWsdl.new
    end

    it "should know when it is connected to service" do
      Savon.should_receive(:client).with(wsdl: 'http://blah.com').and_return([])
      TestServiceWithWsdl.new.should be_connected
    end
  end
end
