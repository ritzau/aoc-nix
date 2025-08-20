{
  description = "Hello World Clojure";
  inputs = {
    aoc-langs.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs =
    {
      self,
      aoc-langs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      aoc-langs.lib.${system}.clojure.mkStandardOutputs {
        src = ./.;
        pname = "hello-clojure";
      }
    );
}
