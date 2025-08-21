{
  description = "Hello World Rust";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.rust.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
      # pname auto-derived from src path as "hello-rust"
    };
}
