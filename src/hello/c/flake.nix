{
  description = "Hello World C";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.c.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
      # gcc defaults to pkgs.gcc
      # pname auto-derived from src path as "hello-c"
    };
}
