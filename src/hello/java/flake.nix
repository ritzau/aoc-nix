{
  inputs = {
    aoc-langs.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { aoc-langs, ... }:
    aoc-langs.lib.mkSimpleFlake ./. {
      description = "Hello World Java";
      language = "java";
    };
}
