Feature: Functionality to parse the response from the SoapObject call

  Scenario: Getting the xml from a response
    Given I use a SoapObject with a remote wsdl named "ZipCodeService"
    When I get the information for zip code "44114"
    Then the results xml should contain "<STATE>OH"

  Scenario: Getting the doc from a response as a Nokogiri object
    Given I use a SoapObject with a remote wsdl named "ZipCodeService"
    When I get the information for zip code "44114"
    And the results doc should be a Nokogiri XML object

  Scenario: Getting a hash from the response
    Given I use a SoapObject with a remote wsdl named "ZipCodeService"
    When I get the information for zip code "44114"
    Then I should be able access the correct response from a hash

  Scenario: Using xpath to parse the response
    Given I use a SoapObject with a remote wsdl named "ZipCodeService"
    When I get the information for zip code "44114"
    Then I should be able access the correct response by xpath
