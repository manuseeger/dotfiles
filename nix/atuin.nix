pkgs:{
  enable = true;
  enableZshIntegration = true;
  settings = {
    enter_accept = true;
    auto_sync = true;
    sync_address = "https://atuin.svc.kieweg.dev";
    sync_frequency = "5m";
    style = "compact";
    workspaces = true;
    filter_mode_shell_up_key_binding = "directory";
  };
}
