{
  config,
  lib,
  pkgs,
  ...
}:
let
  mysddmtheme = pkgs.callPackage ./modules/my-sddm.nix { };
in
{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-hilmi"; # Define your hostname.
  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Jakarta";

  # Enable the X11 windowing system. KDE
  services.xserver = {
    enable = true;
    autoRepeatDelay = 200;
    autoRepeatInterval = 35;
  };
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.libinput.enable = true;

  services.displayManager.sddm = {
    enable = true;
    theme = "my-sddm";
    extraPackages = with pkgs.kdePackages; [
      mysddmtheme
      qtmultimedia
      qt5compat
      qtsvg
    ];
  };

  programs.kdeconnect.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    okular
    kate
    ktexteditor
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "0";
    MOZ_USE_XINPUT = "1";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.hilmi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    git
    kitty
    fastfetch
    nixfmt
    fish
    sbctl
    ffmpeg
    mysddmtheme
    mlocate
  ];
  fonts.packages = with pkgs; [
    cinzel
  ];
  programs.steam.enable = true;
  programs.fish.enable = true;

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "/home/hilmi/nixos-dotfiles";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-files"
    ];
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc-ut
      fcitx5-gtk
    ];
    fcitx5.waylandFrontend = true;
  };
  hardware.graphics.enable = true;
  system.stateVersion = "26.05"; # Did you read the comment?

}
