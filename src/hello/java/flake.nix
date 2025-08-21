{
  description = "Hello World Java";

  inputs = {
    aoc-langs.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self, aoc-langs, ... }:
    aoc-langs.lib.java.mkSimpleFlake self {
      src = ./.;
      # description auto-extracted from self.description
      # jdk defaults to "jdk21"
      # pname auto-derived from src path as "hello-java"
    };
}
