{
  description = "RooSoft's nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-24.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nvim-flake.url = "github:roosoft/nvim-flake";

    project-commander.url = "github:roosoft/project_commander";

    roopkgs = {
      # url = "git+file:/Users/roo/work/test/roopkgs";
      url = "github:roosoft/roopkgs";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs_unstable,
    home-manager,
    darwin,
    roopkgs,
    ...
  } @ inputs: let
    pkgs_unstable = system:
      import nixpkgs_unstable {
        system = system;
        config.allowUnfreePredicate = true;
      };
  in {
    darwinConfigurations = {
      builder = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
        };

        specialArgs = {
          inherit inputs;
          modulesFolder = ./modules;
        };

        modules = [
          ./machines/macOS/builder/darwin-configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                unstable = pkgs_unstable "aarch64-darwin";
                commonFolder = ./common;
              };
              users.roo = {
                imports = [
                  roopkgs.nixosModules.home
                  ./machines/macOS/builder/users/roo/home-manager
                ];
              };
            };
          }
        ];
      };

      traveller = darwin.lib.darwinSystem {
        system = "aarch64-darwin";

        pkgs = import nixpkgs {
          system = "aarch64-darwin";
        };
        
        specialArgs = {
          inherit inputs;
          modulesFolder = ./modules;
        };
        
        modules = [
          ./machines/macOS/traveller/darwin-configuration.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = {
                unstable = pkgs_unstable "aarch64-darwin";
                commonFolder = ./common;
              };
              users.roo = {
                imports = [
                  roopkgs.nixosModules.home
                  ./machines/macOS/traveller/users/roo/home-manager
                ];
              };
            };
          }
        ];
      };
    };
  };
}
