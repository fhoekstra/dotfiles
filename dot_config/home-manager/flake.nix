{
  description = "Home Manager configuration of freek";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      # Define home configurations for each architecture
      configurations = {
        x86_64-linux = home-manager.lib.homeManagerConfiguration {
          inherit (nixpkgs.legacyPackages.x86_64-linux) pkgs;

          modules = [ ./home.nix ];
        };
        aarch64-darwin = home-manager.lib.homeManagerConfiguration {
          inherit (nixpkgs.legacyPackages.aarch64-darwin) pkgs;

          modules = [ ./home.nix ];
        };
      };
    in
    {
      # Specify the home configurations for both architecture types
      homeConfigurations."freek" = configurations.x86_64-linux;
      homeConfigurations."freekhoekstra" = configurations.aarch64-darwin;
    };
}
