{
  inputs.base.url = "path:/Users/ritzau/src/slask/aoc-nix/languages/base";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs =
    {
      self,
      base,
      flake-utils,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        baseLib = base.lib.${system};
      in
      {
        devShells.default = baseLib.mkLanguageShell {
          name = "Nim";
          emoji = "👑";
          languageTools = [ baseLib.pkgs.nim ];
        };
        lib.mkSolution =
          args:
          baseLib.mkSolution (
            {
              language = "nim";
              languageFlake = self;
            }
            // args
          );
      }
    )
    // {
      mkStandardOutputs =
        args:
        flake-utils.lib.eachDefaultSystem (
          system:
          self.lib.${system}.mkSolution {
            package = base.lib.${system}.buildFunctions.simpleCompiler {
              compiler = base.lib.${system}.pkgs.nim;
              fileExtensions = [ "nim" ];
              compileCmd = "nim compile --verbosity:0 -o:hello-nim *.nim";
            } ({ pkgs = base.lib.${system}.pkgs; } // args);
          }
        );
    };
}
