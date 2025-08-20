{
  description = "Hello World C (TEST - using local languages repo)";
  inputs = {
    aoc-langs.url = "path:../../../aoc-polyglot-languages";
  };
  outputs =
    { self, aoc-langs }:
    aoc-langs.lib.${builtins.currentSystem}.c.mkStandardOutputs {
      src = ./.;
      pname = "hello-c";
    };
}
