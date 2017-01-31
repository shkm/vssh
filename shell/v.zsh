v() {
  vagrant_commands=(box connect destroy global-status halt help init login
                    package plugin port powershell provision push rdp reload
                    resumescp share snapshot ssh-config status suspend up
                    version rsync-auto fsnotify)
  if [[ -z "${*}" || "${@}" == "ssh" ]]; then
    vssh
  elif [[ "${vagrant_commands[(r)$1]}" == "$1" ]]; then
    vagrant $*
  else
    vssh "${@}"
  fi
}

