{
  description = "Hello World C#";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages/1b9a1de";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.csharp.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
