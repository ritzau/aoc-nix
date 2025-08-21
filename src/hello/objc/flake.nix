{
  description = "Hello World Objective-C";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    # flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.objc.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
