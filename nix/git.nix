pkgs: lib: isCorporate: customGit: gitUser: gitEmail: with pkgs ; {
  enable = true;
  signing = {
    key = if isCorporate then "20160A1D345FA256DF62A6358E2060EF3800707C" else "";
    signByDefault = if isCorporate then true else false;
  };
  settings = {
    init.defaultBranch = "main";
    user = {
      name = if customGit then gitUser else "Nora Seeger";
      email = if customGit then gitEmail else "nora@seeger.ie";
    };
    pull = {
      rebase=true;
    };
    url = lib.optionalAttrs isCorporate {
      "ssh://git@github.com/10gen/".insteadOf = "https://github.com/10gen/";
    };
  };
}