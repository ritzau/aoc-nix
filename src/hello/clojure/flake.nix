{
  description = "Hello World Clojure";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.clojure.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
