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
    cairo
    pango
    expat
    libxkbcommon
    alsa-lib
  ];
};


xdg.portal = {
  enable = true;
  xdgOpenUsePortal = true;
  extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ];
};

  # services.tailscale = {
  #   enable = true;
  #   openFirewall = true;   # opens Tailscale's own UDP port so direct connections work
  # };

  networking.firewall = {
    enable = false;
    # Option A (simplest): trust everything that comes in over Tailscale.
    # Covers the app (3210) AND the Vite dev server (5173).
    # trustedInterfaces = [ "tailscale0" ];
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
