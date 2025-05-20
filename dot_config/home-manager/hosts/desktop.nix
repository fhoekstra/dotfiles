{
  config,
  pkgs,
  lib,
  ...
}:
{
  services.home-manager.autoExpire = {
    enable = true;
    timestamp = "-7 days";
    frequency = "weekly";
    store = {
      cleanup = true;
      options = "--delete-older-than 30d";
    };
  };
  home.packages = [ pkgs.mise ];
  programs.zsh.initExtra = ''
    eval "$(/usr/bin/mise activate zsh)"
  '';
}
