def project_path
  File.join(File.dirname(__FILE__), '../..')
end

def vssh_path
  File.join(project_path, 'vssh')
end

def version_path
  File.join(project_path, 'VERSION')
end

def harness_path
  File.join(File.dirname(__FILE__), 'harness')
end

def ssh_config_path
  File.join(harness_path, '.vagrant', 'ssh_config')
end

def vssh_config_path
  File.join(harness_path, '.vagrant', 'vssh.cfg')
end

def cleanup_files
  FileUtils.rm [ssh_config_path, vssh_config_path], force: true
end

def stub_ssh
  bin_dir = File.join(File.dirname(__FILE__), 'bin')

  ENV['PATH'] = "#{bin_dir}:#{ENV['PATH']}"

  `chmod +x #{bin_dir}/ssh`
end

def read_output
  @output ||= @stdout.read
end

Before do
  cleanup_files
end

at_exit do
  cleanup_files

  # Stop the box only after the suite is done
  FileUtils.cd harness_path
  `vagrant halt`
end

stub_ssh
