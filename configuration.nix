
{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
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
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
  services.desktopManager.plasma6.enable = true;
  services.libinput.enable = true;
  programs.kdeconnect.enable = true;
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    ark
    okular
    kate
    ktexteditor
  ];

  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "0";
    MOZ_USE_XINPUT = "1";
  };

  environment.etc."mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json".source =
  "${pkgs.kdePackages.plasma-browser-integration}/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json";

# Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.hilmi = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
     ];
  };


   environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    kitty
    peazip 
    fastfetch
    kdePackages.plasma-browser-integration
   ];

    programs.steam.enable = true;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
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

  system.stateVersion = "26.05"; # Did you read the comment?

}
