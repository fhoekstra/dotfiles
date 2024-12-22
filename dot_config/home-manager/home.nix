{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./common.nix
    (import ./host.nix)
  ];
}
