pkgs: config: isCorporate: with pkgs ; {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  dotDir = "${config.home.homeDirectory}/.config/zsh";
  history.size = 10000;
  envExtra = if isCorporate then ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
    export KUBECONFIG="/Users/ms/repos/kube-resources/.kube/config:/Users/ms/.kube/config"
    export PATH="''${PATH}:''${KREW_ROOT:-$HOME/.krew}/bin"
  '' else "";


  
  oh-my-zsh = {
    enable = true;
    plugins = [
        "git"
        "golang"
        "z"
        "kubectl"
        "docker"
        "fzf"
    ];
    theme = "robbyrussell";
  };
}
