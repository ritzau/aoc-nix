{
  description = "Hello World D";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.d.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
