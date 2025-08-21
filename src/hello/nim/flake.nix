{
  description = "Hello World Nim";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.nim.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
