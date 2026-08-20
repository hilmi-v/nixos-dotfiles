  {
    pkgs,
    ...
  }:
  {
  programs.git = {
    enable = true;
    settings.user = {
      name = "hilmi-v";
      email = "alfalahhilmi@gmail.com";
    };

  };

 home.packages = [
    (pkgs.writeShellScriptBin "spotify-run" ''
      spotify --enable-features=UseOzonePlatform --ozone-platform=wayland --enable-gpu-rasterization "$@"
    '')
  ];

  home.file.".zen/native-messaging-hosts/org.kde.plasma.browser_integration.json".source =
    "${pkgs.kdePackages.plasma-browser-integration}/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json";

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

   programs.fastfetch = {
  enable = true;
  settings = {
    logo = {
      type = "kitty"; 
      source = "../../assets/f.jpg";
      width = 36;
      height = 36;
    };
  };
  };

  home.sessionVariables = {
    EDITOR = "code --wait";
    VISUAL = "code --wait";
  };

  }