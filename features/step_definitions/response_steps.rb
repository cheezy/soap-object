When(/^I get the information for zip code "([^"]*)"$/) do |zip_code|
  sleep 0.5 #throttle requests to remote wsdl
  using(@cls).get_zip_code_info(zip_code)
end

Then /^the results xml should contain "(.*?)"$/ do |xml|
  using(@cls) do |so|
    xml_response = so.to_xml
    expect(xml_response).to be_an_instance_of(String)
    expect(xml_response).to include xml
  end
end

Then /^the results doc should be a Nokogiri XML object$/ do
  using(@cls) do |so|
    expect(so.doc).to be_instance_of Nokogiri::XML::Document
  end
end

Then /^I should be able access the correct response from a hash$/ do
  using(@cls) do |so|
    expect(so.body).to be_an_instance_of(Hash)
    expect(so.state).to eq('OH')
    expect(so.city).to eq('Cleveland')
    expect(so.area_code).to eq('216')
  end
end

Then(/^I should be able access the correct response by xpath$/) do
  using(@cls) do |so|
    expect(so.xpath('//Table/STATE').first.text).to eq('OH')
    expect(so.xpath('//Table/CITY').first.text).to eq('Cleveland')
    expect(so.xpath('//Table/AREA_CODE').first.text).to eq('216')
  end
end
