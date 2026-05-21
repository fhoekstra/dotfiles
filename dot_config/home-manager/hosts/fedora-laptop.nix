{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./personal.nix
  ];
  # theme = "light";
  programs.zsh.initContent = ''
    eval "$(/home/freek/.local/bin/mise activate zsh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
  '';
}
