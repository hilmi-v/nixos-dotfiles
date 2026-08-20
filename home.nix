{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
  home.username = "hilmi";
  home.homeDirectory = "/home/hilmi";
  home.stateVersion = "26.05";

  imports = [
    ./modules/deploy.nix
    ./modules/home/packages.nix
    ./modules/home/program.nix
    ./modules/home/fetch.nix
  ];
}
