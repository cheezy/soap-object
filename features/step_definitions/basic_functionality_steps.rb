class TestServiceWithWsdl
  include SoapObject

  wsdl 'http://www.webservicex.net/uszip.asmx?WSDL'
  log_level :error

  def get_zip_code_info(zip_code)
    get_info_by_zip 'USZip' => zip_code
  end

  def state
    message[:state]
  end

  def city
    message[:city]
  end

  def area_code
    message[:area_code]
  end

  private

  def message
    body[:get_info_by_zip_response][:get_info_by_zip_result][:new_data_set][:table]
  end
end

class TestServiceWithLocalWsdl
  include SoapObject

  wsdl "#{File.dirname(__FILE__)}/../wsdl/uszip.asmx.wsdl"
end

class TestDefineService
  include SoapObject

  wsdl "http://services.aonaware.com/DictService/DictService.asmx?WSDL"
  log_level :error

  def definition_for(word)
    define word: word
  end
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
  expect(@so).to be_connected
end

Then /^I should be able to determine the operations$/ do
  expect(@so.operations).to include :get_info_by_zip
end

Then /^I should be able to make a call and receive the correct results$/ do
  @so.get_zip_code_info(90210)
  expect(@so.state).to eq('CA')
  expect(@so.city).to  eq('Beverly Hills')
  expect(@so.area_code).to eq('310')
end

Then /^the results xml should contain "(.*?)"$/ do |xml|
  expect(@so.to_xml).to include xml
end

Then /^the results doc should be a Nokogiri XML object$/ do
  expect(@so.doc).to be_instance_of Nokogiri::XML::Document
end

Given /^I am calling the Define service$/ do
  @cls = TestDefineService
end

Then /^I should be able to get the correct definition results$/ do
  @so.definition_for 'Cheese'
end
