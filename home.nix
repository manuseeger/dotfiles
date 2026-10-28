{ callPackage, config, pkgs, homeDirectory, username,  ...}:

{
  imports = [
    ./nix/tmux.nix
    ./nix/atuin.nix
    ./nix/zsh.nix
    ./nix/starship.nix
  ];

  home.packages = with pkgs; [
    git
    neovim
    zsh
    fzf
    tmux
    starship
    oh-my-zsh
    go
    ripgrep
    jq
    atuin
    zsh-syntax-highlighting
    zsh-autosuggestions
    oh-my-zsh
    firefox
    syncthing
    vscodium
    kubectl
    kubectx
    podman
    podman-compose
    k9s
    bitwarden-desktop
    obsidian
  ];

  programs.git = {
    enable = true;
    settings = {    
      user = {
        name = "Nora Seeger";
        email = "nora@seeger.ie";
      };
    };
  };

  programs.home-manager = {
    enable = true;
    backupFileExtension = "hm-backup";
  };
}
