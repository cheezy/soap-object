Given /^I have the url for a remote wsdl$/ do
  @cls = ZipCodeService
end

Given /^I have a wsdl file residing locally$/ do
  @cls = LocalWsdlService
end

Given /^I use a SoapObject with a remote wsdl named "(.*?)"$/ do |service_class|
  @cls = Object.const_get(service_class)
end

When /^I create an instance of the SoapObject class$/ do
  using(@cls)
end

Then /^I should have a connection$/ do
  expect(using(@cls)).to be_connected
end

Then /^I should be able to determine the operations$/ do
  operations = using(@cls).operations
  expect(operations).to include :get_info_by_zip
end

Then /^I should be able to successfully call "(.*?)" with "(.*?)"$/ do |operation, args|
  using(@cls).send(operation, args)
end
