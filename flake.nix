{
  description = "Home Manager configuration of ns";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs, home-manager, ... }:
    let
      system = "aarch64-darwin";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      homeConfigurations = {
        ns = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
            {
              home = {
                username = "ns";
                homeDirectory = "/Users/ns";
                stateVersion = "26.05";
              };
            }
            {
              nixpkgs.config.allowUnfree = true;
            }
            ./home.nix ];
        };
      };
    };
}
