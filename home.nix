{ config, lib, pkgs, specialArgs, ... }:

let
  packages = import ./nix/packages.nix;
  tmuxSettings = import ./nix/tmux.nix;
  atuinSettings = import ./nix/atuin.nix;
  zshSettings = import ./nix/zsh.nix;
  starshipSettings = import ./nix/starship.nix;
  goSettings = import ./nix/go.nix;
  gitSettings = import ./nix/git.nix;

  inherit (specialArgs) customGit gitUser gitEmail isDesktop isCorporate;
  inherit (lib) mkIf;
  inherit (pkgs.stdenv) isLinux isDarwin;
in
{
  nixpkgs.config.allowUnfree = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  home.packages = packages pkgs isDesktop isCorporate;
  home.homeDirectory = "/home/ns";
  home.username = "ns";
  home.stateVersion = "26.05";
 
  programs.zsh = zshSettings pkgs config isCorporate;
  programs.tmux = tmuxSettings pkgs;
  programs.atuin = atuinSettings pkgs;
  programs.starship = starshipSettings pkgs;
  programs.go = goSettings pkgs lib isCorporate;
  programs.git = gitSettings pkgs lib isCorporate customGit gitUser gitEmail;
  
  programs.jq.enable = true;
  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    settings = {
      "Github.com" = {
        addKeysToAgent = "yes";
        identityFile = "~/.ssh/github";
      };
    };
  };
  programs.fzf.enable = true;

  programs.vscodium = mkIf isDesktop {
    enable = true;
    profiles.default = {
      userSettings = {
        "workbench.colorTheme" = "Nord";
      };
      extensions = with pkgs.vscode-extensions; [
        ms-kubernetes-tools.vscode-kubernetes-tools
        golang.go
        jnoortheen.nix-ide
        arcticicestudio.nord-visual-studio-code
    ];
    };
  };

}
