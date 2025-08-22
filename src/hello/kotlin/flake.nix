{
  description = "Hello World Kotlin";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.kotlin.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
