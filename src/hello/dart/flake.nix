{
  description = "Hello World Dart";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.dart.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
