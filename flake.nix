{
  description = "RooSoft's nix config";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs_unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home manager
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    flake-utils.url = "github:numtide/flake-utils";

    # TODO: Add any other flake you might need
    # hardware.url = "github:nixos/nixos-hardware";

    # Shameless plug: looking for a way to nixify your themes and make
    # everything match nicely? Try nix-colors!
    # nix-colors.url = "github:misterio77/nix-colors";
    neovim-flake = {
      url = "github:roosoft/neovim-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    nixpkgs_unstable,
    home-manager,
    flake-utils,
    ...
  } @ inputs: flake-utils.lib.eachDefaultSystem (system: let
    pkgs_unstable = import nixpkgs_unstable {
      system = system;
      config.allowUnfreePredicate = true;
    };
  in {
    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      nixos-mini = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;}; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [./machines/nixos-mini/configuration.nix];
      };
      nixos-lenovo = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;}; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [./machines/nixos-lenovo/configuration.nix];
      };
      macOS = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;}; # Pass flake inputs to our config
        # > Our main nixos configuration file <
        modules = [./machines/macOS/darwin-configuration.nix];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      "roo@nixos-mini" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        extraSpecialArgs = {inherit inputs pkgs_unstable;}; # Pass flake inputs to our config
        modules = [./machines/nixos-mini/users/roo/home.nix];
      };
      "roo@nixos-lenovo" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        extraSpecialArgs = {inherit inputs pkgs_unstable;}; # Pass flake inputs to our config
        modules = [./machines/nixos-lenovo/users/roo/home.nix];
      };
    };
  });
}
