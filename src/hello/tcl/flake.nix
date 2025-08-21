{
  description = "Hello World Tcl";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.tcl.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
