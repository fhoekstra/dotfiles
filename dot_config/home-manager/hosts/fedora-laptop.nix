{
  config,
  pkgs,
  lib,
  ...
}:
{
  # theme = "light";
  home.packages = [ pkgs.mise ];
  programs.zsh.initExtra = ''
    eval "$(mise activate zsh)"
  '';
}
