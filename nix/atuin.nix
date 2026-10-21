{ pkgs, lib, config, ... }:
with lib; let
  cfg = config.features.tools.atuin;
in {
  options.features.tools.atuin.enable = mkEnableOption "enable atuin with config";
  config = mkIf cfg.enable {
    programs.atuin = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        auto_sync = true;
        sync_address = "https://atuin.svc.kieweg.dev";
        sync_frequency = "5m";
        style = "compact";
        workspaces = true;
      };
    };
  };
}
