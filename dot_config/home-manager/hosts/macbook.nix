{
  config,
  pkgs,
  lib,
  ...
}:
let
  username = "freekhoekstra";
  homeDir = "/Users/${username}";
  HOME = homeDir;
  colima_env_vars = ''
    export DOCKER_HOST="unix://${HOME}/.colima/docker.sock"
    export TESTCONTAINERS_HOST_OVERRIDE=127.0.0.1
    export TESTCONTAINERS_DOCKER_SOCKET_OVERRIDE=/var/run/docker.sock
    export TESTCONTAINERS_RYUK_DISABLED=true
  '';
in
{
  home.packages = [
    pkgs.joplin # notes
    pkgs.azure-cli
    pkgs.kubelogin # Azure Kubernetes login
  ];
  home.username = username;
  home.homeDirectory = homeDir;

  home.sessionVariables.K9S_CONFIG_DIR = "${homeDir}/.config/k9s";

  home.shellAliases = {
    nx = "npx nx";
    nb = "netbird";
  };
  programs.zsh.initContent = ''
    ssh-add --apple-load-keychain -q

    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

    ${colima_env_vars}

    eval "$(mise activate zsh)"

    source ~/.safe-chain/scripts/init-posix.sh # Aikido safe-chain
  '';
}
