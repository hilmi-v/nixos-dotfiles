{
  pkgs,
  inputs,
  ...
}:
{
  home.packages = [
    (inputs.zen-browser.packages.${pkgs.system}.default.override {
      nativeMessagingHosts = [ pkgs.kdePackages.plasma-browser-integration ];
    })
    pkgs.anki
    pkgs.steam
    pkgs.obsidian
    pkgs.mpv
    pkgs.libreoffice-qt
    pkgs.vscode
    pkgs.code-cursor
    pkgs.darkly
    pkgs.kdePackages.krohnkite
    pkgs.spotify-spotx
    pkgs.lutris
  ];
}
