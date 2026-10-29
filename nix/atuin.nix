pkgs:{
  enable = true;
  enableZshIntegration = true;
  settings = {
    auto_sync = true;
    sync_address = "https://atuin.svc.kieweg.dev";
    sync_frequency = "5m";
    style = "compact";
    workspaces = true;
  };
}
