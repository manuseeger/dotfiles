pkgs:{
  enable = true;
  # aggressiveResize = true; -- Disabled to be iTerm-friendly
  baseIndex = 1;
  newSession = true;
  # Stop tmux+escape craziness.
  escapeTime = 0;
  mouse = true;
  clock24 = true;
  historyLimit = 50000;

  plugins = with pkgs; [
    tmuxPlugins.sensible
    tmuxPlugins.prefix-highlight
    tmuxPlugins.nord
  ];

  extraConfig = ''
    # easy-to-remember split pane commands
    bind | split-window -h
    bind - split-window -v
    unbind '"'
    unbind %

    # reload config file (change file location to your the tmux.conf you want to use)
    bind r source-file ~/.tmux.conf

    # switch panes using Alt-arrow without prefix
    bind -n M-Left select-pane -L
    bind -n M-Right select-pane -R
    bind -n M-Up select-pane -U
    bind -n M-Down select-pane -D

    bind -n C-z run-shell "tmux new-session -d; tmux split-window -h; tmux split-window -h; tmux select-layout even-vertical; tmux attach-session"
  '';
}
