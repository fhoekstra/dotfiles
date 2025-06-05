# dotfiles

These are my dotfiles. I manage them with [chezmoi](https://www.chezmoi.io/) and [Nix Home Manager](https://nix-community.github.io/home-manager/).
`chezmoi` is a simple but flexible Git-based dotfiles tool.
`nix` is a package manager, configuration and programming language and OS. I use it with the Home Manager project to be able to use recent versions of the terminal tools I love, anywhere, regardless of OS, and completely native, i.e. no VMs or OCI containers.

Some of the tools I manage with these config files are:
- neovim, a powerful fully-featured IDE that runs in the terminal. I use a very close to vanilla [LazyVim](http://www.lazyvim.org/) and am very happy with its ease of use and documentation
- [kanshi](https://git.sr.ht/~emersion/kanshi), which I used in combination with [SwayWM](https://swaywm.org/) to manage external displays on my laptop.
- [gitui](https://github.com/extrawurst/gitui) and [lazygit](https://github.com/jesseduffield/lazygit). I initially used gitui, but due to a problem with SSH keys, I moved to lazygit, which I have been using with completely default setup so far.
- [tmux](https://github.com/tmux/tmux/wiki). I customised some bindings to harmonize them with LazyVim and added a tokyo-night theme using Tmux Plugin Manager
- zsh with a simple [oh-my-zsh](https://ohmyz.sh/) config

## Install

Make sure you have `git` installled.
Then install chezmoi, pull and apply the latest version of these dotfiles with a single command:
```
GITHUB_USERNAME=fhoekstra
git --version && sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME
```

Then, install Nix:
```
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Finally, install home-manager:
```
nix run home-manager/release-25.05 --no-write-lock-file -- init --switch -b backup
```
Files that were already present (such as `.zshrc`) will get the `.backup` suffix (i.e. you will find your previous zshrc in `~/.zshrc.backup`
