{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

let
  username = "user"; # <--- Your username here
  activeTheme = "gruvbox"; # <--- Your single source of truth
in
{
  # This makes 'activeTheme' available to all NixOS modules
  # defined in this system configuration
  _module.args = { inherit activeTheme; };

  # 🔓 ALLOW UNFREE PACKAGES
  nixpkgs.config.allowUnfree = true;

  # 🌐 CORE NETWORKING & HARDWARE
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  };

  programs.waybar.enable = true;

  # Popular Compositor Flags
  programs.hyprland.enable = false;
  programs.niri.enable = false;
  programs.mangowc.enable = true;

  # Sway flags
  programs.sway = {
    enable = true;
    package = pkgs.swayfx; # This swaps standard sway out for swayfx!
  };

  # Qtile even on wayland packaged by xorg
  services.xserver.enable = false;
  services.xserver.windowManager.qtile = {
    enable = false;
  };

  # System Services
  security.polkit.enable = true;
  };

  environment.systemPackages = with pkgs; [
    lazygit
    git
    curl
    wget
    unzip
    nixd
    zip
    tree
    wlogout
    matugen
    grim
    nil
    ripgrep
    wl-clipboard
    cliphist
    fastfetch
    neovim
  ];

  # Pipewire Sound Architecture
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  programs.dconf.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Shell Configuration
  programs.fish.enable = true;

  # User Account Map
  users.users."${username}" = {
    isNormalUser = true;
    description = "${username}";
    shell = pkgs.fish;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "input"
      "lp"
      "scanner"
    ];
  };

  # Dynamic Home Manager User Target Profile
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "backup";
    extraSpecialArgs = {
      inherit inputs username activeTheme;
    };
    users."${username}" = {
      # Use lib.mkForce to resolve the path conflict
      home.homeDirectory = lib.mkForce "/home/${username}";
      imports = [ ./home.nix ];
    };
  };

  # 👑 SYSTEM COMPATIBILITY VERSION
  system.stateVersion = "26.05";
}
