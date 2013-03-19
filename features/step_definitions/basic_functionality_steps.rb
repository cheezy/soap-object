class TestServiceWithWsdl
  include SoapObject

  wsdl 'http://www.webservicex.net/airport.asmx?WSDL'
  log_level :error

  def get_airport_name_for(airport_code)
    response = get_airport_information_by_airport_code airport_code: airport_code
    doc = Nokogiri::XML(response)
    doc.xpath('//Table/CityOrAirportName').first.content
  end
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
end

Then /^I should have a connection$/ do
  @so.should be_connected
end

Then /^I should be able to determine the operations$/ do
  @so.operations.should include :get_airport_information_by_airport_code
end

Then /^I should be able to make a call and receive the correct results$/ do
  @so.get_airport_name_for('SFO').should == 'SAN FRANCISCO INTL'
end

Then /^the results body should contain "(.*?)"$/ do |body|
  @so.body.should include body
end
