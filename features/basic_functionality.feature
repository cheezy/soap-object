@focus
Feature: This describes the core functionality of the SoapObject object

  Scenario: Establishing communications with remote wsdl
    Given I have the url for a remote wsdl
    When I create an instance of the SoapObject class
    Then I should have a connection

  Scenario: Establishing communications with a local wsdl
    Given I have a wsdl file residing locally
    When I create an instance of the SoapObject class
    Then I should have a connection

  Scenario: Providing operations when using wsdl
    Given I have the url for a remote wsdl
    When I create an instance of the SoapObject class
    Then I should be able to determine the operations

  Scenario: Calling a service when using wsdl
    Given I have the url for a remote wsdl
    When I create an instance of the SoapObject class
    Then I should be able to make a call and receive the correct results

  Scenario: Getting the xml from a response
    Given I have the url for a remote wsdl
    When I create an instance of the SoapObject class
    Then I should be able to make a call and receive the correct results
    And the results xml should contain "<STATE>CA"

  Scenario: Getting the doc from a response as a Nokogiri object
    Given I have the url for a remote wsdl
    When I create an instance of the SoapObject class
    Then I should be able to make a call and receive the correct results
    And the results doc should be a Nokogiri XML object

  Scenario: Calling another service with wsdl
    Given I am calling the Define service
    When I create an instance of the SoapObject class
    Then I should be able to get the correct definition results

