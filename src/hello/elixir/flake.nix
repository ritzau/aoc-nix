{
  description = "Hello World Elixir";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.elixir.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
