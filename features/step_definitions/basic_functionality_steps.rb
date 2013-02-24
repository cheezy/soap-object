class TestServiceWithWsdl
  include SoapObject

  wsdl 'http://www.webservicex.net/airport.asmx?WSDL'
end

Given /^I have the url for a remote wsdl$/ do
  @cls = TestServiceWithWsdl
end

When /^I create an instance of the SoapObject class$/ do
  @so = @cls.new
  @so.wsdl.should_not be_nil
end

Then /^I should have a connection$/ do
  @so.client.should_not be_nil
end
