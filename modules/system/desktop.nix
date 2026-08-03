{
  pkgs,
  ...
}:
let
  mysddmtheme = pkgs.callPackage ../my-sddm.nix { };
in
{

  environment.systemPackages = with pkgs; [
    mysddmtheme
  ];
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

}