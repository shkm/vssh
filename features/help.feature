Feature: Help
  Scenario: Query vssh for help
    Given I execute vssh with the "--help" argument
    Then the help info is displayed
