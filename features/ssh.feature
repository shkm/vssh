Feature: SSH
  Given the box is running
  Scenario: First-time ssh into a box
    And I am under the vagrant box folder
    And I execute vssh
    And I accept the prompt to create vssh.cfg with a root of "/bin"
    Then the vssh.cfg file is generated
    And the vssh.cfg value of "root" is "/bin"
    And the ssh_config file is generated
    And I am ssh'd into the box at "/bin"

  Scenario: ssh into a box with valid configs
    And I am under the vagrant box folder
    And an ssh_config file exists
    And a vssh.cfg file exists
    And I execute vssh
    Then I am ssh'd into the box at "/vagrant"

  Scenario: Directly run a command inside the box
    And I am under the vagrant box folder
    And an ssh_config file exists
    And a vssh.cfg file exists
    And I execute vssh with the "uname" argument
    Then the command "uname" is run inside the box at "/vagrant"
