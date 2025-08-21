{
  description = "Hello World Ada";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.ada.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
