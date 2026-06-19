{
  description = "NixOS Flake with Noctalia (Hyprland & Niri)";

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
      home-manager,
      ...
    }:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          home-manager.nixosModules.home-manager
          ./modules/limine.nix
          /etc/nixos/hardware-configuration.nix
          ./configuration.nix
          ./modules/system.nix
          ./modules/regreet.nix
          ./modules/apps.nix
          ./modules/devices.nix
          ./modules/gaming.nix
          ./niri/niri.nix
          ./mango/mango.nix
          ./hypr/hyprland.nix
          ./sway/sway.nix
        ];
      };
    };
}
