{
  description = "RooSoft's nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    darwin.url = "github:lnl7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    neovim-flake = {
      url = "github:roosoft/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , nixpkgs_unstable
    , home-manager
    , flake-utils
    , darwin
    , neovim-flake
    , ...
    } @ inputs:
    let
      pkgs_unstable = system: import nixpkgs_unstable {
        system = system;
        config.allowUnfreePredicate = true;
      };
    in
    {
      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        nixos-mini = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [ ./machines/nixos-mini/configuration.nix ];
        };
        nixos-lenovo = nixpkgs.lib.nixosSystem {
          specialArgs = { inherit inputs; }; # Pass flake inputs to our config
          modules = [ ./machines/nixos-lenovo/configuration.nix ];
        };
      };

      darwinConfigurations = {
        builder = darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          pkgs = import nixpkgs {
            system = "aarch64-darwin";
          };
          specialArgs = { inherit inputs; modulesFolder = ./modules; }; # Pass flake inputs to our config
          # > Our main nixos configuration file <
          modules = [
            ./machines/macOS/builder/darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { commonFolder = ./common; };
                users.roo = {
                  imports = [ ./machines/macOS/builder/users/roo/home-manager ];
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
          specialArgs = { inherit inputs; modulesFolder = ./modules; }; # Pass flake inputs to our config
          # > Our main nixos configuration file <
          modules = [
            ./machines/macOS/traveller/darwin-configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                extraSpecialArgs = { commonFolder = ./common; };
                users.roo = {
                  imports = [ ./machines/macOS/traveller/users/roo/home-manager ];
                };
              };
            }
          ];
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations =
        let
          pkgs = pkgs_unstable "x86_64-linux";
        in
        {
          "roo@nixos-mini" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";
            extraSpecialArgs = { inherit inputs pkgs; commonFolder = ./common; };
            modules = [ ./machines/nixos-mini/users/roo/home.nix ];
          };
          "roo@nixos-lenovo" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages."x86_64-linux";

            extraSpecialArgs = { inherit inputs pkgs; commonFolder = ./common; };
            modules = [ ./machines/nixos-lenovo/users/roo/home.nix ];
          };
        };
    };
}
