{
  config,
  pkgs,
  lib,
  stylix,
  ...
}:
{
  stylix.enable = true;
  stylix.image = ./scarlet-tree.png;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-latte.yaml";
  programs.zsh.initExtra = "";
}
