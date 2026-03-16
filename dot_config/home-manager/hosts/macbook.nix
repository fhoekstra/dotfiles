{
  config,
  pkgs,
  lib,
  ...
}:
let
  username = "freekhoekstra";
  homeDir = "/Users/${username}";
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

  programs.zsh.initContent = ''
    ssh-add --apple-load-keychain -q
    export NVM_DIR="$HOME/.nvm"
    [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
    alias nx='npx nx'
  '';
}
