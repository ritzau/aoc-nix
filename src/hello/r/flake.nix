{
  description = "Hello World R";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.r.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
