class TestServiceWithWsdl
  include SoapObject

  wsdl 'http://www.webservicex.net/airport.asmx?WSDL'
end

class TestServiceWithLocalWsdl
  include SoapObject

  wsdl "#{File.dirname(__FILE__)}/../wsdl/airport.asmx.wsdl"
end


Given /^I have the url for a remote wsdl$/ do
  @cls = TestServiceWithWsdl
end

Given /^I have a wsdl file residing locally$/ do
  @cls = TestServiceWithLocalWsdl
end

When /^I create an instance of the SoapObject class$/ do
  @so = @cls.new
  @so.wsdl.should_not be_nil
end

Then /^I should have a connection$/ do
  @so.should be_connected
end
