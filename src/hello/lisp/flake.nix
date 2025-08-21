{
  description = "Hello World Lisp";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.lisp.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
