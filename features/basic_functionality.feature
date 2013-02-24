@focus
Feature: This describes the core functionality of the SoapObject object

  Scenario: Establishing communications with remote wsdl
    Given I have the url for a remote wsdl
    When I create an instance of the SoapObject class
    Then I should have a connection


