{
  description = "Hello World OCaml";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.ocaml.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
