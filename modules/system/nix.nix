{
    nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
  };
  system.autoUpgrade = {
    enable = true;
    dates = "weekly";
    flake = "/home/hilmi/nixos-dotfiles";
    flags = [
      "--update-input"
      "nixpkgs"
      "--commit-lock-files"
    ];
  };
}
