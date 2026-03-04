{
  config,
  pkgs,
  lib,
  ...
}:
let
  username = "freekhoekstra";
in
{
  home.packages = [
    pkgs.joplin
  ];
  home.username = username;
  home.homeDirectory = "/Users/${username}";

  programs.zsh.initContent = ''
    ssh-add --apple-load-keychain -q
  '';
}
