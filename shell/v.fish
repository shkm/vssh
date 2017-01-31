function v -d "Vagrant/vssh"
  set -l commands box connect destroy global-status halt help init login package plugin port powershell provision push rdp reload resumescp share snapshot ssh-config status suspend up version rsync-auto fsnotify

  if contains -- $argv[1] $commands
    vagrant $argv
  else
    vssh $argv
  end
end

