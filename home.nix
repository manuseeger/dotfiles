{ config, lib, pkgs, specialArgs, ... }:

let
  packages = import ./nix/packages.nix;
  tmuxsettings = import ./nix/tmux.nix;
  atuinsettings = import ./nix/atuin.nix;
  zshsettings = import ./nix/zsh.nix;
  starshipsettings = import ./nix/starship.nix;

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
 
  programs.zsh = zshsettings pkgs config;
  programs.tmux = tmuxsettings pkgs;
  programs.atuin = atuinsettings pkgs;
  programs.starship = starshipsettings pkgs;
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

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = if customGit then gitUser else "Nora Seeger";
        email = if customGit then gitEmail else "nora@seeger.ie";
      };
      pull = {
        rebase=true;
      };
    };
  };
}
