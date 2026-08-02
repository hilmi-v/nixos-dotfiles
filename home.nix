{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  home.username = "hilmi";
  home.homeDirectory = "/home/hilmi";
  home.stateVersion = "26.05";

  imports = [
    inputs.spicetify-nix.homeManagerModules.default
    ./deploy.nix
  ];

  programs.git = {
    enable = true;
    settings.user = {
      name = "hilmi-v";
      email = "alfalahhilmi@gmail.com";
    };

  };

  programs.bash = {
    enable = true;
    shellAliases = {
      testaja = "just nix btw";
    };
  };
  home.file.".zen/native-messaging-hosts/org.kde.plasma.browser_integration.json".source =
    "${pkgs.kdePackages.plasma-browser-integration}/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json";

  home.packages = [
    (inputs.zen-browser.packages.${pkgs.system}.default.override {
      nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    })
    pkgs.anki
    pkgs.persepolis
    pkgs.steam
    pkgs.obsidian
    pkgs.mpv
    pkgs.libreoffice-qt
    pkgs.vscode
    pkgs.darkly
    pkgs.kdePackages.krohnkite
  ];

  # Konfigurasi Spicetify
  programs.spicetify = {
    enable = true;

    theme = spicePkgs.themes.sleek;
    colorScheme = "BladeRunner";

    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      copyLyrics
      powerBar
    ];
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/plain" = [ "code.desktop" ];
      "text/markdown" = [ "code.desktop" ];
      "application/x-zerosize" = [ "code.desktop" ];

      "text/html" = "zen.desktop";
      "x-scheme-handler/http" = "zen.desktop";
      "x-scheme-handler/https" = "zen.desktop";
      "x-scheme-handler/about" = "zen.desktop";
      "x-scheme-handler/unknown" = "zen.desktop"; # For empty files
    };
  };

  home.sessionVariables = {
    EDITOR = "code --wait";
    VISUAL = "code --wait";
  };

}
