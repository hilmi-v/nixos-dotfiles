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

    spotifyPackage = pkgs.spotify.overrideAttrs (oldAttrs: {
      postInstall = (oldAttrs.postInstall or "") + ''
        wrapProgram $out/bin/spotify \
          --add-flags "--disable-gpu"
      '';
    });
    theme = spicePkgs.themes.sleek;
    customColorScheme = {
      text = "c3c7d1";
      subtext = "d7d7d7";
      nav-active-text = "222E32";
      main = "222E32";
      sidebar = "222E32";
      player = "222E32";
      card = "222E32";
      shadow = "0e0e13";
      main-secondary = "09111b";
      button = "bb3634";
      button-secondary = "bb3634";
      button-active = "E03F3C";
      button-disabled = "192531";
      nav-active = "E03F3C";
      play-button = "bb3634";
      tab-active = "09111b";
      notification = "192531";
      notification-error = "192531";
      playback-bar = "bb3634";
      misc = "FFFFFF";
    };

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
