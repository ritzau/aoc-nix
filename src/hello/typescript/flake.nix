{
  description = "Hello World TypeScript";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.typescript.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
