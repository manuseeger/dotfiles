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
    export PATH="''${PATH}:''${ZDOTDIR:-$HOME}/.zsh/completion"
    export PATH="''${PATH}:''${HOME}/go/bin"
    
    # mms
    export MMS_HOME=~/repos/mms
    export AWS_PROFILE=mms-scratch
    export M_PREFIX=~
    # export BAZEL_TELEMETRY=0   # only if you run with ONBOARDING_NO_LOCAL_CLOUD=1

    # ~/bin on PATH (preonboarding's homebin check)
    [[ ''${path[(i)$HOME/bin]} -le ''${#path} ]] || path=($HOME/bin $path)

    # ant.py raises if ANT_HOME is set but missing, so guard it
    [[ -d $HOME/apache-ant-1.10.5 ]] && export ANT_HOME=$HOME/apache-ant-1.10.5

    # mms-automation
    export CM_ROOT=~/repos/mms-automation/go_planner
  '' else "";
  initContent = if isCorporate then ''
    # asdf (brew, no asdf.sh needed) -- literal "asdf.sh" kept for onboarding's grep
    export PATH="''${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"
    # set-java-home.zsh
    [[ -f $HOME/.asdf/plugins/java/set-java-home.zsh ]] && . $HOME/.asdf/plugins/java/set-java-home.zsh
  ''else "";


  
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
