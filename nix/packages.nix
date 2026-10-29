pkgs: isDesktop: with pkgs; [
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
  syncthing
  kubectl
  kubectx
  podman
  podman-compose
  k9s
] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
  scroll-reverser
] ++ pkgs.lib.optionals isDesktop [
  firefox
  vscodium
  bitwarden-desktop
  obsidian
]
