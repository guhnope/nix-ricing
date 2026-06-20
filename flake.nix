{
  description = "NixOS Flake for multi-compositor testing";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    mango = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    scroll = {
      url = "github:Diax170/scroll-flake"; # Community flake
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      scroll,
      mango,
      home-manager,
      ...
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          inputs.scroll.nixosModules.default
          ./modules/limine.nix
          /etc/nixos/hardware-configuration.nix
          ./configuration.nix
          ./modules/system.nix
          ./modules/regreet.nix
          ./modules/apps.nix
          ./modules/devices.nix
          ./modules/gaming.nix
          ./compositors/common.nix
          ./compositors/hyprland.nix
          ./compositors/sway.nix
        ];
      };
    };
}
