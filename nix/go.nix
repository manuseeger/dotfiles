pkgs: lib: isCorporate: with pkgs ; {
  enable = true;
  env.GOPRIVATE = lib.optionals isCorporate [ "github.com/10gen/*" ];
}