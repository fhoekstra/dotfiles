{
  config,
  pkgs,
  lib,
  ...
}:
{
  # theme = "light";
  programs.zsh.initExtra = ''
    eval "$(/usr/bin/mise activate zsh)"
  '';
}
