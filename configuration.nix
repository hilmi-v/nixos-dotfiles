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
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXrender
    xorg.libXcursor
    xorg.libXi
    xorg.libXtst
    xorg.libxcb
    xorg.libxshmfence

    # Graphics
    libGL
    vulkan-loader
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
