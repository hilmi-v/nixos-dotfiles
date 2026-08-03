{
  boot.loader.systemd-boot.enable = true;
  boot.loader.systemd-boot.configurationLimit = 5;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos-hilmi"; # Define your hostname.
  networking.networkmanager.enable = true;

  hardware.bluetooth.enable = true;
  hardware.graphics.enable = true;
  hardware.sane.enable = true;

  services.printing.enable = true;
  services.power-profiles-daemon.enable = true;
}