{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/system/core.nix
    ./modules/system/locale.nix
    ./modules/system/nix.nix
    ./modules/system/desktop.nix
    ./modules/system/packages.nix
    ./modules/system/packages.nix
  ];
programs.nix-ld = {
  enable = true;

  libraries = with pkgs; [
    # Basic runtime libraries
    zlib
    zstd
    stdenv.cc.cc
    curl
    openssl
    libssh
    bzip2
    libxml2
    xz

    # Browser / Electron / React Native DevTools
    nspr
    nss
    gtk3
    glib
    libgbm
    libdrm

    # X11
    libX11
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrandr
    libXrender
    libXcursor
    libXi
    libXtst
    libxcb
    libxshmfence

    # Graphics
    libGL
    vulkan-loader

    dbus
    atk
    cups
  ];
};
  users.users.hilmi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
  system.stateVersion = "26.05"; 

}
