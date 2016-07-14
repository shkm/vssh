require 'Open3'

Given /^I execute vssh(?: with the "([^"]*)" argument(?:s)?)?$/ do |args|
  @stdin, @stdout, @wait = Open3.popen2(vssh_path, *args)
end

Given /^I do not accept the prompt to create vssh\.cfg$/ do
  @stdin.puts "n"
  @stdin.close
end

Given /^I accept the prompt to create vssh\.cfg with a root of "(.*)"/ do |root|
  @stdin.write('y')
  @stdin.write("#{root}\n")
  @stdin.close
  @wait.value
end

Given /^I am under the vagrant box folder$/ do
  FileUtils.cd harness_path
end

Given /^the box is running$/ do
  return if @box_running

  pwd = Dir.pwd
  FileUtils.cd harness_path

  `vagrant up`

  FileUtils.cd pwd

  @box_running = true
end

Given /^an (empty )?ssh_config file exists$/ do |empty|
  contents = empty ? '' : 'not empty'

  File.open ssh_config_path, 'w' do |file|
    file.write contents
  end
end

Given /^a vssh\.cfg file exists$/ do
  File.open vssh_config_path, 'w' do |file|
    file.write 'root="/vagrant"'
  end
end

Then /^the version info is displayed$/ do
  version_number = File.read(version_path)
  expect(read_output).to eq "vssh #{version_number}"
end

Then /^the help info is displayed$/ do
  version_number = File
                   .read(version_path)
                   .sub(/\n$/, '')

  expect(read_output.gsub(/ {3,}/, '')).to eq <<~OUTPUT
    vssh #{version_number}

    Usage: vssh [options] [command]
      --version\tPrint the vssh version
      --help\tDisplay this message
      --config\tInteractively generate a new vssh config
      --refresh\tRefresh ssh config cache from Vagrant
  OUTPUT
end

Then /^The ssh_config file exists$/ do
  expect(File.exist?(vssh_config_path)).to eq true
end

Then /^the ssh_config file is generated$/ do
  steps %Q{
    The ssh_config file exists
  }

  @output
  expect(read_output).to include("Vagrant ssh config not found; generating.")
end

Then /^the ssh_config file is refreshed$/ do
  steps %Q{
    The ssh_config file exists
  }

  expect(read_output).to include("Refreshing vagrant ssh config.")
end

Then /^the vssh\.cfg file is generated$/ do
  expect(File.exist?(vssh_config_path)).to eq true
end

Then /^the vssh\.cfg value of "(.*)" is "(.*)"$/ do |var, value|
  expect(File.read(vssh_config_path)).to include(%(#{var}="#{value}"))
end

Then /^the command "(.*)" is run inside the box at "(.*)"$/ do |command, dir|
  expect(read_output).to include("ssh args: -F .vagrant/ssh_config "\
                                  "-q -t default cd #{dir}; $SHELL -l -c \"#{command}\"")
end

Then /^I am ssh'd into the box at "(.*)"$/ do |dir|
  expect(read_output).to include("ssh args: -F .vagrant/ssh_config "\
                                  "-q -t default cd #{dir}; $SHELL -l")
end

Then /^I am ssh'd into the box$/ do
  steps %Q{
    I am ssh'd into the box at "/vagrant"
  }
end
