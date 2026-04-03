{
  config,
  pkgs,
  lib,
  ...
}:
let
  secrets = if builtins.pathExists ../local-secrets.nix then (import ../local-secrets.nix) else { };
in
{
  home.packages = [
    pkgs.joplin
  ];
  home.sessionVariables = {
    # LC_ALL = "C.UTF-8";
    EDITOR = "nvim";
    MISTRAL_API_KEY = secrets.MISTRAL_API_KEY or "";
  };
}
