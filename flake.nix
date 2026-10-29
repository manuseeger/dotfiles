# https://github.com/jonringer/nixpkgs-config
{
  description = "Home Manager configuration";

  inputs = {
    utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self, nixpkgs, home-manager, utils }:
    let
      pkgsForSystem = system: import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      mkHomeConfiguration = args: home-manager.lib.homeManagerConfiguration ( rec {
        modules = [ (import ./home.nix) ] ++ (args.modules or []);
        pkgs = pkgsForSystem (args.system); 
      } // { inherit (args) extraSpecialArgs; });
    in utils.lib.eachSystem [ "x86_64-linux" "aarch64-darwin" "aarch64-linux" ] (system: rec {
      legacyPackages = pkgsForSystem system;
      devShells.default = with legacyPackages; mkShell {
        packages = [ home-manager.packages.${system}.default ];
      };
    }) // {
      nixosModules.home = import ./home.nix;

      homeConfigurations.ada = mkHomeConfiguration {
        system = "aarch64-darwin";
        modules = [ ({lib,...}:
        {
          home.username = lib.mkForce "mk";
          home.homeDirectory = lib.mkForce "/Users/mk";
        })];
        extraSpecialArgs = {
          isDesktop = true;
        };
      };

      homeConfigurations.eris = mkHomeConfiguration {
        system = "aarch64-darwin";
        modules = [ ({lib,...}:
        {
          home.homeDirectory = lib.mkForce "/Users/ns";
        })];
        extraSpecialArgs = {
          isDesktop = true;
        };
      };

      homeConfigurations.mongodb = mkHomeConfiguration {
        system = "aarch64-darwin";
        modules = [ ({lib , config, ...}:
        {
          home.username = lib.mkForce "ms";
          home.homeDirectory = lib.mkForce "/Users/ms";
        })];
        extraSpecialArgs = {
          isDesktop = true;
          isCorporate = true;
          customGit = true;
          gitUser = "Manu Seeger";
          gitEmail = "manu.seeger@mongodb.com";
        };
      };

      homeConfigurations.v = mkHomeConfiguration {
        system = "x86_64-linux";
        modules = [ ({lib,...}:
        {
          home.username = lib.mkForce "manu";
          home.homeDirectory = lib.mkForce "/home/manu";
        })];
        extraSpecialArgs = {
          isDesktop = true;
        };
      };

      homeConfigurations.rpi = mkHomeConfiguration {
        system = "aarch64-linux";
        modules = [ ({lib,...}:
        {
          home.username = lib.mkForce "mk";
          home.homeDirectory = lib.mkForce "/Users/mk";
        })];
        extraSpecialArgs = {
          isDesktop = false;
        };
      };

      homeConfigurations.balrog = mkHomeConfiguration {
        system = "x86_64-linux";
        modules = [ ({lib,...}:
        {
          home.username = lib.mkForce "mk";
          home.homeDirectory = lib.mkForce "/Users/mk";
        })];
        extraSpecialArgs = {
          isDesktop = false;
        };
      };
    inherit home-manager;
    inherit (home-manager) packages;
  };
}
