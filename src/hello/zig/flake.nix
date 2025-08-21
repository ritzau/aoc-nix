{
  description = "Hello World Zig";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.zig.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
      # pname auto-derived from src path as "hello-zig"
    };
}
