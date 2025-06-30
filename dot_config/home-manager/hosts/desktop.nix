{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = [ pkgs.mise ];
  programs.zsh.initContent = ''
    eval "$(/usr/bin/mise activate zsh)"
  '';
}
