{
    nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.auto-optimise-store = true;
  nix.optimise.automatic = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
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
