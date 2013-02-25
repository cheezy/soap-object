class TestServiceWithWsdl
  include SoapObject

  wsdl 'http://www.webservicex.net/airport.asmx?WSDL'
end

class TestServiceWithLocalWsdl
  include SoapObject

  wsdl "#{File.dirname(__FILE__)}/../wsdl/airport.asmx.wsdl"
end

class TestServiceWithoutWsdl
  include SoapObject

  endpoint "http://www.webservicex.net/airport.asmx"
  namespace "http://www.webserviceX.NET"
end



Given /^I have the url for a remote wsdl$/ do
  @cls = TestServiceWithWsdl
end

Given /^I have a wsdl file residing locally$/ do
  @cls = TestServiceWithLocalWsdl
end

Given /^I have the endpoint and namespace$/ do
  @cls = TestServiceWithoutWsdl
end

When /^I create an instance of the SoapObject class$/ do
  @so = @cls.new
end

Then /^I should have a connection$/ do
  @so.should be_connected
end

Then /^I should be able to determine the operations$/ do
  @so.operations.should include :get_airport_information_by_airport_code
end

Then /^I should not be able to determine the operations$/ do
  @so.operations.should be_nil
end
