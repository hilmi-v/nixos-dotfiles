{ config, pkgs, ... }:

{
  # If you imported nix-flatpak.homeManagerModules.nix-flatpak in your flake.nix, 
  # you can directly use services.flatpak here:
  services.flatpak = {
    enable = true;

    # Add your declarative Flatpak apps here
    packages = [
      "org.freedownloadmanager.Manager"
      "https://kolbyml.github.io/Manatan/io.github.kolbyml.Manatan.flatpakref"
    ];

    # Optional: Automatically update flatpaks on activation or via timers
    update.auto = {
      enable = true;
      onCalendar = "weekly";
    };

    # Optional: If you want Home Manager to remove any flatpaks 
    # that you didn't declare here (e.g. installed manually via CLI)
    uninstallUnmanaged = false; 
  };
}