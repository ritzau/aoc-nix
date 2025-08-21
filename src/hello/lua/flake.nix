{
  description = "Hello World Lua";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, polyglot, ... }:
    polyglot.lib.lua.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
