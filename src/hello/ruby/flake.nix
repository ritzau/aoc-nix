{
  description = "Hello World Ruby";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.ruby.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
