{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    ./personal.nix
  ];
  # theme = "light";
  programs.zsh.initContent = ''
    PATH="$PATH:/home/freek/.cargo/bin"
    eval "$(/home/freek/.local/bin/mise activate zsh)"
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"
  '';
}
