{
  config,
  pkgs,
  lib,
  ...
}:
{
  # theme = "light";
  programs.zsh.initExtra = ''
    eval "$(/home/freek/.local/bin/mise activate zsh)"
  '';
}
