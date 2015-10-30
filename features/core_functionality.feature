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

  Scenario Outline: Calling a service with a remote wsdl
    When I use a SoapObject with a remote wsdl named "<soap-object>"
    Then I should be able to successfully call "<operation>" with "<args>"
    Examples:
      | soap-object    | operation         | args   |
      | DefineService  | definition_for    | Cheese |
      | ZipCodeService | get_zip_code_info | 44114  |
