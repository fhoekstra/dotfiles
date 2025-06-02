{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = [ pkgs.mise ];
  programs.zsh.initExtra = ''
    eval "$(/usr/bin/mise activate zsh)"
  '';
}
