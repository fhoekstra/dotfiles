{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = [
    pkgs.neovim
  ];
  programs.neovim.enable = lib.mkForce false;
  services.home-manager.autoExpire = {
    enable = true;
    timestamp = "-7 days";
    frequency = "weekly";
    store = {
      cleanup = true;
      options = "--delete-older-than 30d";
    };
  };
  programs.zsh.initExtra = ''
    # Extra init stuff goes here
  '';
}
