{
  pkgs,
  lib,
  inputs,
  ...
}:
{

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
    mlocate
  ];

  # exclude optional kde app
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    konsole
    elisa
    okular
    kate
    ktexteditor
  ];

  # firefox to work
  environment.sessionVariables = {
    MOZ_ENABLE_WAYLAND = "0";
    MOZ_USE_XINPUT = "1";
  };  

  # font
  fonts.packages = with pkgs; [
    cinzel
  ];


  programs.steam.enable = true;
  programs.fish.enable = true;
  programs.kdeconnect.enable = true;

  nixpkgs.config.allowUnfree = true;
   nixpkgs = {
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "spotify"
        "spotify-spotx"
      ];
    overlays = [ inputs.spotx-nix.overlays.default ];
  };
  

# keyboard
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      fcitx5-mozc-ut
      fcitx5-gtk
    ];
    fcitx5.waylandFrontend = true;
  };

}