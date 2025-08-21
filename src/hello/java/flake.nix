{
  description = "Hello World Java";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.java.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
      # jdk defaults to pkgs.jdk21
      # pname auto-derived from src path as "hello-java"
    };
}
