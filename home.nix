{ callPackage, config, pkgs, ...}:

{
  imports = [
    ./nix/tmux.nix
    ./nix/atuin.nix
  ];
}

{
  home.packages = [
    pkgs.git
    pkgs.neovim
    pkgs.zsh
    pkgs.fzf
    pkgs.tmux
    pkgs.starship
    pkgs.oh-my-zsh
    pkgs.go
    pkgs.ripgrep
    pkgs.jq
    pkgs.atuin
    pkgs.zsh-syntax-highlighting
    pkgs.zsh-autosuggestions
    pkgs.oh-my-zsh
    pkgs.firefox
    pkgs.syncthing
    pkgs.vscodium
    pkgs.kubectl
    pkgs.kubectx
    pkgs.podman
    pkgs.podman-compose
    pkgs.k9s
    pkgs.iterm
  ];
  
  home.file.".zshrc" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/dotfiles/.config/zsh/.zshrc";
  };

  xdg.configFile = {
  "zsh" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/repos/dotfiles/.config/zsh";
    recursive = true;
  };

  programs.git = {
    enable = true;
    userName = "Nora Seeger";
    userEmail = "nora@seeger.ie"
  };
}
