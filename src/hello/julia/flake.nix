{
  description = "Hello World Julia";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.julia.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
