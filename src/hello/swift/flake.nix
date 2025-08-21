{
  description = "Hello World Swift";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.swift.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
