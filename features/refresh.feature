Feature: Refresh
  Scenario: Force ssh_config refresh
    Given the box is running
    And I am under the vagrant box folder
    And a vssh.cfg file exists
    And an empty ssh_config file exists
    And I execute vssh with the "--refresh" argument
    Then the ssh_config file is refreshed
    And I am ssh'd into the box
