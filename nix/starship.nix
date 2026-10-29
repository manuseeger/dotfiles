pkgs:{
  enable = true;
  # Configuration written to ~/.config/starship.toml
  settings = {
    time.disabled = false;
    kubernetes = {
      disabled = false;
      format = "'on [⛵ ($user on )($cluster in )$context \($namespace\)](dimmed green) '";
    };
  };
}
