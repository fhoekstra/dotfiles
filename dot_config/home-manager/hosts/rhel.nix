{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.username = "adm-hoekstrf";
  home.homeDirectory = "/home/adm-hoekstrf";
  # theme = "tokyo-night";
  programs.zsh.initExtra = ''
    # Start ssh-agent-switcher if it hasn't been started yet.
    # This program makes sure the SSH Agent is not lost when disconnecting and then later reconnecting to a tmux session.
    if [ ! -e "/tmp/ssh-agent.$USER" ]; then
        if [ -n "$ZSH_VERSION" ]; then
            eval ~/.local/bin/ssh-agent-switcher 2>/dev/null "&!"
        else
            ~/.local/bin/ssh-agent-switcher 2>/dev/null &
            disown 2>/dev/null || true
        fi
    fi
    export SSH_AUTH_SOCK="/tmp/ssh-agent.$USER"

    # Source our DBA scripts
    source ~/git/dba-ansible-automation/dev-bin/shell-functions.rc

    # Add alias for login to Kubernetes cluster
    alias klog='oc login -u hoekstrf --server=https://api.ota-int.containerhostingplatform.nl:6443'
  '';
}
