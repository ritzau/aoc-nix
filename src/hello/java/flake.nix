{
  description = "Hello World Java";

  inputs = {
    aoc-langs.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, aoc-langs, ... }:
    aoc-langs.lib.java.mkSimpleFlake self {
      # description auto-extracted from self.description
      # src auto-extracted from self.outPath
      # jdk defaults to "jdk21"
    };
}
