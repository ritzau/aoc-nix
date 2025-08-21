{
  description = "Hello World Java";

  inputs = {
    aoc-langs.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { aoc-langs, ... }:
    aoc-langs.lib.mkSimpleFlake ./. {
      inherit description;
      language = "java";
    };
}
