{
  description = "Hello World Python 3.12";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.python.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
      # Override to use Python 3.12 instead of default 3.11
      python = polyglot.inputs.nixpkgs.legacyPackages.x86_64-darwin.python312;
    };
}
