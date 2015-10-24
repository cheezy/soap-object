Given /^I have the url for a remote wsdl$/ do
  @cls = RemoteWsdlService
end

Given /^I have a wsdl file residing locally$/ do
  @cls = LocalWsdlService
end

Given /^I am calling the Define service$/ do
  @cls = DefineService
end

When /^I create an instance of the SoapObject class$/ do
  @so = @cls.new(Savon)
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

Then /^I should be able to get the correct definition results$/ do
  @so.definition_for 'Cheese'
end
