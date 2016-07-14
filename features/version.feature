Feature: Version
  Scenario: Query vssh for version info
    Given I execute vssh with the "--version" argument
    Then the version info is displayed
