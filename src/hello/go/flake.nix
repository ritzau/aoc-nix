{
  description = "Hello World Go";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.go.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
      # pname auto-derived from src path as "hello-go"
    };
}
