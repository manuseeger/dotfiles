pkgs: isDesktop: isCorporate: with pkgs; [
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
] ++ pkgs.lib.optionals isCorporate [
  gh
] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
  scroll-reverser
  iterm2
] ++ pkgs.lib.optionals isDesktop [
  firefox
  vscodium
  bitwarden-desktop
  obsidian
]
