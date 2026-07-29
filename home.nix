{
  config,
  pkgs,
  inputs,
  ...
}:

let
  # Mengambil library package dari spicetify-nix untuk tema dan ekstensi
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in
{
  home.username = "hilmi";
  home.homeDirectory = "/home/hilmi";
  home.stateVersion = "26.05";

  # Impor modul spicetify untuk Home Manager
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

  ];

  # Konfigurasi Spicetify
  programs.spicetify = {
    enable = true;

    # Tema dan skema warna (Contoh: Catppuccin Mocha)
    theme = spicePkgs.themes.sleek;
    colorScheme = "BladeRunner";

    # Ekstensi yang ingin diaktifkan
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      coverAmbience
      copyLyrics
      powerBar
    ];
  };
}
