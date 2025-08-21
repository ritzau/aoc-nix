{
  description = "Hello World Python";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.python.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
      # python defaults to pkgs.python311
      # pname auto-derived from src path as "hello-python"
    };
}
