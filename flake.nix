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
    areofyl-fetch = {
      url = "github:areofyl/fetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-flatpak = {
    #   url = "github:gmodena/nix-flatpak/?ref=latest";
    # };
    claude-code.url = "github:sadjow/claude-code-nix";
    local-cashier.url = "git+file:///home/hilmi/projects/local_cashier";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      # lanzaboote,
      spotx-nix,
      # nix-flatpak,
      claude-code,
      local-cashier,
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
              backupFileExtension = "backup";
              extraSpecialArgs = { inherit inputs; };
              users.hilmi = {
                imports =[
                  ./home.nix
                  # nix-flatpak.homeManagerModules.nix-flatpak
                ];
              };
            };
            nixpkgs.overlays = [ claude-code.overlays.default ];
          }
           local-cashier.nixosModules.default
        {
          services.local-cashier = {
            enable = true;
            appDir = "/home/hilmi/local_cashier";   # the checkout, already built
            user = "hilmi";
            # dataDir defaults to /var/lib/local-cashier
            # port defaults to 3210
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
