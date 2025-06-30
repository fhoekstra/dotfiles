{
  config,
  pkgs,
  lib,
  ...
}:
{
  # theme = "light";
  programs.zsh.initContent = ''
    eval "$(/home/freek/.local/bin/mise activate zsh)"
  '';
}
