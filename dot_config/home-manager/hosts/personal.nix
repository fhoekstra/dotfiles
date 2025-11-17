{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = [
    pkgs.joplin
    pkgs.resumed
  ];
}
