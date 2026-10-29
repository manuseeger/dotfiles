pkgs: config: with pkgs ; {
  enable = true;
  enableCompletion = true;
  autosuggestion.enable = true;
  syntaxHighlighting.enable = true;
  dotDir = "${config.home.homeDirectory}/.config/zsh";
  history.size = 10000;

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
