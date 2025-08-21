{
  description = "Hello World PHP";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.php.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
