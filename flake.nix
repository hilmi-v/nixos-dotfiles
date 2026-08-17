{
  description = "MY Nixos";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # lanzaboote = {
    #   url = "github:nix-community/lanzaboote/v1.1.0";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    spotx-nix = {
      url = "github:SpotX-Official/SpotX-Nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      # lanzaboote,
      spotx-nix,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos-hilmi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.hilmi = import ./home.nix;
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs; };
            };
          }

          # secure boot
          # lanzaboote.nixosModules.lanzaboote
          # ({ pkgs, lib, ... }: {
          #   boot.loader.systemd-boot.enable = lib.mkForce false;
          #   boot.lanzaboote = {
          #     enable = true;
          #     pkiBundle = "/var/lib/sbctl";
          #   };
          #  })
        ];
      };
    };

}
