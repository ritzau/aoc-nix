{
  description = "Hello World Dart";
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
      aoc-langs.lib.${system}.dart.mkStandardOutputs {
        src = ./.;
        pname = "hello-dart";
      }
    );
}
