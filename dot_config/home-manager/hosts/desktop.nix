{
  config,
  pkgs,
  lib,
  ...
}:
{
  home.packages = [
    pkgs.mise
    pkgs.cosign
  ];
  programs.zsh.initContent = ''
    eval "$(mise activate zsh)"
    export PATH=$PATH:~/.local/bin/
  '';
  home.shellAliases = {
    rmpkg = "sudo pacman -Rsn";
    cleanch = "sudo pacman -Scc";
    fixpacman = "sudo rm /var/lib/pacman/db.lck";
    update = "sudo pacman -Syu";
    cleanup = "sudo pacman -Rsn $(pacman -Qtdq)";
  };
  home.sessionVariables = {
    HISTCONTROL = "ignoreboth";
    HISTIGNORE = "&:[bf]g:c:clear:history:exit:q:pwd:* --help";
    LESS_TERMCAP_md = "$(tput bold 2> /dev/null; tput setaf 2 2> /dev/null)";
    LESS_TERMCAP_me = "$(tput sgr0 2> /dev/null)";
    PROMPT_COMMAND = "history -a; $PROMPT_COMMAND";
  };

}
