nix-env --delete-generations old --profile ~/.local/state/nix/profiles/home-manager &&
  nix-env --delete-generations old --profile ~/.local/state/nix/profiles/profile &&
  sudo nix-collect-garbage -d &&
  nix store optimise
