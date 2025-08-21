{
  description = "Hello World Scala";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.scala.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
      # jdk defaults to pkgs.jdk21
      # pname auto-derived from src path as "hello-scala"
    };
}
