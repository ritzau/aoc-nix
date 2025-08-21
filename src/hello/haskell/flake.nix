{
  description = "Hello World Haskell";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.haskell.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
