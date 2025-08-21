# AOC Solutions with Nix

A polyglot Advent of Code (AOC) solution repository using Nix flakes for reproducible development environments across 21+ programming languages.

## Quick Start

### Prerequisites

- [Nix](https://nixos.org/download.html) with flakes enabled
- [direnv](https://direnv.net/) (recommended for automatic environment switching)

### Setup

1. **Clone the repository:**

   ```bash
   git clone <your-repo-url>
   cd aoc-nix
   ```

2. **Enable direnv (recommended):**

   ```bash
   echo "use flake" > .envrc
   direnv allow
   ```

3. **Or use Nix directly:**
   ```bash
   nix develop
   ```

## Supported Languages

This repository supports solutions in 21+ programming languages:

- **JVM**: Java, Kotlin, Scala
- **Systems**: C, C++, Rust, Go, Zig
- **Scripting**: Python, Perl, Ruby, PHP
- **Functional**: Haskell, OCaml, Elixir, Lisp
- **Other**: Clojure, D, Fortran, Swift, Tcl

Each language has its own development environment with tools, libraries, and AOC-relevant packages pre-configured.

## Project Structure

```
aoc-nix/
├── src/hello/              # Hello World examples for each language
│   ├── python/
│   │   ├── flake.nix      # Language environment configuration
│   │   ├── hello.py       # Hello world program
│   │   └── .envrc         # direnv configuration
│   ├── java/
│   ├── rust/
│   └── ...
├── solutions/              # Your AOC solutions (not in repo)
│   └── YEAR/dayXX/LANG/   # Per-day, per-language solutions
└── inputs/                 # AOC input files (not in repo)
    └── YEAR/dayXX.txt
```

## Creating Solutions

### 1. Choose a Language

Navigate to any hello world example to see the setup:

```bash
cd src/hello/python
nix develop  # or direnv allow
```

### 2. Copy Template

Copy a hello world template for your solution:

```bash
mkdir -p solutions/2024/day01/python
cp -r src/hello/python/* solutions/2024/day01/python/
```

### 3. Develop Your Solution

```bash
cd solutions/2024/day01/python
direnv allow  # Enters development environment automatically

# Edit your solution
vim solution.py

# Run it
python solution.py

# Build a package (optional)
nix build

# Run the built package
nix run
```

## Language Examples

### Python

```bash
cd src/hello/python
nix develop
python hello.py
```

Features:

- Python 3.11 (configurable)
- Scientific libraries: NumPy, NetworkX, SymPy
- Development tools: pytest, black, mypy
- AOC-specific utilities

### Java

```bash
cd src/hello/java
nix develop
javac Hello.java && java Hello
```

Features:

- JDK 21 (configurable)
- Build tools and common libraries
- Development environment with IDE support

### Rust

```bash
cd src/hello/rust
nix develop
cargo run
```

Features:

- Latest Rust toolchain
- cargo, rustfmt, clippy
- Common crates for AOC problems

### Custom Language Versions

Some languages support version overrides:

**Python 3.12 Example:**

```nix
{
  description = "AOC Solution with Python 3.12";

  inputs.polyglot.url = "github:ritzau/aoc-polyglot-languages";

  outputs = { self, polyglot, ... }:
    polyglot.lib.python.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
      python = polyglot.inputs.nixpkgs.legacyPackages.x86_64-darwin.python312;
    };
}
```

## Development Workflow

### Per-Language Environment

Each solution directory is self-contained:

```bash
cd solutions/2024/day01/python
direnv allow                    # Auto-enter environment
python solution.py < input.txt  # Run solution
pytest test_solution.py         # Run tests
nix build                       # Build package
nix run                         # Run built package
```

### Cross-Language Benchmarking

Use `hyperfine` to compare solutions:

```bash
cd solutions/2024/day01
hyperfine 'python/solution.py < input.txt' \
          'java/Main < input.txt' \
          'rust/target/release/main < input.txt'
```

### Available Tools

All environments include:

- Language-specific compiler/interpreter
- Package managers (cargo, pip, npm, etc.)
- Formatters and linters
- Testing frameworks
- Universal tools: git, rg, fd, tree, bat, jq, curl, wget
- Benchmarking: hyperfine
- Development: bottom, htop, delta

## Input Management

### AOC Input Files

Store your personal AOC inputs in `inputs/`:

```
inputs/
├── 2023/
│   ├── day01.txt
│   ├── day02.txt
│   └── ...
└── 2024/
    ├── day01.txt
    └── ...
```

**Note**: Personal input files should not be committed to version control per AOC guidelines.

### Linking Inputs

Link input files to solution directories:

```bash
cd solutions/2024/day01/python
ln -s ../../../../inputs/2024/day01.txt input.txt
```

## Flake Configuration

### Basic Flake Structure

Each solution uses this minimal flake.nix:

```nix
{
  description = "AOC 2024 Day 1 - Python";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, polyglot, ... }:
    polyglot.lib.python.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
    };
}
```

### Advanced Configuration

**With custom packages:**

```nix
polyglot.lib.java.mkDefaultOutputs {
  inherit (self) description;
  src = ./.;
  jdk = pkgs.jdk17;  # Use JDK 17 instead of default 21
}
```

**With custom package name:**

```nix
polyglot.lib.rust.mkDefaultOutputs {
  inherit (self) description;
  src = ./.;
  pname = "aoc-day01-rust";
  version = "1.0.0";
}
```

## Testing

### Run Individual Solutions

```bash
cd solutions/2024/day01/python
nix build          # Build check
nix run            # Run solution
nix flake check    # All checks
```

### Test Development Environment

```bash
nix develop --command python --version
nix develop --command java --version
```

## Performance and Optimization

### Language Comparison

Use the multi-language setup to:

- Compare algorithm implementations
- Benchmark execution time
- Analyze memory usage
- Test different approaches

### Profiling

Each environment includes profiling tools:

- Python: cProfile, line_profiler
- Java: JProfiler integration
- Rust: cargo flamegraph
- C++: valgrind, gprof

## Troubleshooting

### Common Issues

**"flake not found" errors:**

```bash
# Make sure you're in a directory with flake.nix
ls flake.nix

# Update flake lock if needed
nix flake update
```

**"attribute missing" errors:**

```bash
# Check supported languages
nix flake show github:ritzau/aoc-polyglot-languages

# Verify language name spelling
nix eval .#polyglot.lib --apply builtins.attrNames
```

**Environment activation issues:**

```bash
# Manual activation if direnv not working
nix develop

# Check direnv status
direnv status
```

### Getting Help

1. Check language-specific documentation in `src/hello/LANGUAGE/`
2. Review the polyglot library docs: [aoc-polyglot-languages](https://github.com/ritzau/aoc-polyglot-languages)
3. Run `nix develop --command just --list` to see available commands
4. Use `nix flake show` to inspect available outputs

## Examples

See `src/hello/` for working examples of all supported languages. Each directory contains:

- Working hello world program
- Proper flake.nix configuration
- Language-specific usage notes

## Contributing

To add new languages or improve existing ones:

1. Contribute to the [aoc-polyglot-languages](https://github.com/ritzau/aoc-polyglot-languages) library
2. Add hello world examples to this repository
3. Update documentation

## License

This template repository is provided as-is for AOC participants. Individual solutions and modifications are your own.
