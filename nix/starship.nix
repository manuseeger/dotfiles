pkgs:{
  enable = true;
  # Configuration written to ~/.config/starship.toml
  settings = {
    username.show_always = true;
    time.disabled = false;
    kubernetes = {
      disabled = false;
      format = "[$symbol$context( ($namespace))]($style) in ";
      style = "cyan bold";
      symbol = "⛵ ";
    };
  };
}
