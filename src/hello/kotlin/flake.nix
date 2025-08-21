{
  description = "Hello World Kotlin";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    # flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.kotlin.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
