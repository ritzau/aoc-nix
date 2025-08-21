{
  description = "Hello World JavaScript";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.javascript.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
