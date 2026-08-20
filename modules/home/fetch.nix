{ pkgs, inputs, ... }:

{
  imports = [ inputs.areofyl-fetch.homeManagerModules.default ];

  programs.fetch = {
    enable = true;
    labelColor = "red";
    info = [
      "os"
      "kernel"
      "uptime"
      "host"
      "kernel"
      "uptime"
      "packages"
      "shell"
      "display"
      "wm"
      "theme"
      "icons"
      "font"
      "terminal"
      "cpu"
      "gpu"
      "memory"
      "swap"
      "disk"
      "ip"
      "battery"
      "locale"
      "colors"
    ];
    speed = 1.0;
    spin = "xy";
    size = 2.0;
  };

    programs.fastfetch = {
    enable = true;
    settings = {
      logo = {
        type = "kitty";
        source = "/home/hilmi/nixos-dotfiles/assets/f.jpg";
        width = 70;
        height = 30;
      };
      modules = [
        "title"
        "separator"
        "os"
        "host"
        "kernel"
        "uptime"
        "packages"
        "shell"
        "display"
        "de"
        "wm"
        "terminal"
        "cpu"
        "gpu"
        "memory"
        "swap"
        "disk"
        "colors"
      ];
    };
  };

}
