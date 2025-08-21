{
  description = "Hello World Perl";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.perl.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
