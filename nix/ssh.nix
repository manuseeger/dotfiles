pkgs:{
  enable = true;
  enableDefaultConfig = false;
  settings = {
    "Github.com" = {
      addKeysToAgent = "yes";
      identityFile = "~/.ssh/github";
    };
    "quagmire" = {
      addKeysToAgent = "yes";
      hostname = "159.69.21.61";
      user = "mk";
      identityFile = "~/.ssh/hetzner";
    };
    "vaughan" = {
      addKeysToAgent = "yes";
      hostname = "192.168.0.252";
      user = "mk";
      identityFile = "~/.ssh/bsd-nas";
    };
    "wandelworte" = {
      addKeysToAgent = "yes";
      hostname = "proxy.cloud.kieweg.dev";
      user = "mk";
      identityFile = "~/.ssh/ww-hetzner";
    };
    "ahab" = {
      addKeysToAgent = "yes";
      hostname = "192.168.0.12";
      user = "mk";
      identityFile = "~/.ssh/homelab";
    };
    "legolas" = {
      addKeysToAgent = "yes";
      hostname = "192.168.0.11";
      user = "mk";
      identityFile = "~/.ssh/homelab";
    };
    "aragorn" = {
      addKeysToAgent = "yes";
      hostname = "192.168.0.10";
      user = "mk";
      identityFile = "~/.ssh/homelab";
    };
    "balrog" = {
      addKeysToAgent = "yes";
      hostname = "192.168.0.206";
      user = "mk";
      identityFile = "~/.ssh/k8s-nodekey";
    };
    "galadried" = {
      addKeysToAgent = "yes";
      hostname = "192.168.0.89";
      user = "mk";
      identityFile = "~/.ssh/homelab";
    };
  };
}