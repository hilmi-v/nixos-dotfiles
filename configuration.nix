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
  ];

  users.users.hilmi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };
  system.stateVersion = "26.05"; 

}
