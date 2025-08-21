# Development Guide

This document covers the development workflow, architecture decisions, and contribution guidelines for the AOC Nix repository.

## Repository Purpose

This repository serves as:

1. **Example Collection**: Hello world examples for all supported languages
2. **Template Repository**: Starting point for AOC solution repositories
3. **Testing Ground**: Validation of the polyglot language library
4. **Documentation**: Real-world usage examples and patterns

## Architecture

### Design Principles

1. **Language Independence**: Each solution is self-contained
2. **Minimal Boilerplate**: Simple flake.nix files with essential configuration
3. **Consistent Structure**: All languages follow the same directory layout
4. **Environment Isolation**: Each language has its own development environment
5. **Tool Integration**: Pre-configured with AOC-relevant tools and libraries

### Directory Structure

```
aoc-nix/
├── README.md              # User-facing documentation
├── DEVELOPMENT.md         # This file
├── src/                   # Example implementations
│   └── hello/            # Hello world for each language
│       ├── python/       # Python example
│       │   ├── flake.nix
│       │   ├── hello.py
│       │   └── .envrc
│       ├── java/         # Java example
│       └── ...           # Other languages
├── solutions/            # User solutions (gitignored)
└── inputs/              # AOC inputs (gitignored)
```

### Flake Architecture

Each language example follows this pattern:

```nix
{
  description = "Hello World LANGUAGE";

  inputs = {
    polyglot.url = "github:ritzau/aoc-polyglot-languages";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, polyglot, ... }:
    polyglot.lib.LANGUAGE.mkDefaultOutputs {
      inherit (self) description;
      src = ./.;
      # Optional language-specific parameters
    };
}
```

This creates:

- **Package**: Built executable from source files
- **App**: Runnable version of the package
- **Dev Shell**: Development environment with tools
- **Checks**: Build verification

## Development Workflow

### Setting Up Development Environment

1. **Prerequisites**:

   ```bash
   # Install Nix with flakes
   curl -L https://nixos.org/nix/install | sh
   echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf

   # Install direnv (optional but recommended)
   nix profile install nixpkgs#direnv
   ```

2. **Clone and setup**:
   ```bash
   git clone <repo>
   cd aoc-nix
   nix develop  # or direnv allow
   ```

### Testing Changes

#### Individual Language Testing

```bash
cd src/hello/python
nix build && nix run      # Test build and execution
nix develop --command python --version  # Test dev environment
nix flake check          # Run all checks
```

#### Batch Testing

```bash
# Test all languages build
find src/hello -name flake.nix -execdir nix build \;

# Test all dev environments
for lang in src/hello/*/; do
  echo "Testing $lang..."
  cd "$lang" && nix develop --command echo "OK" && cd -
done
```

### Adding New Language Examples

1. **Check language support** in [aoc-polyglot-languages](https://github.com/ritzau/aoc-polyglot-languages)
2. **Create directory structure**:

   ```bash
   mkdir src/hello/newlang
   cd src/hello/newlang
   ```

3. **Create flake.nix**:

   ```nix
   {
     description = "Hello World NewLang";

     inputs = {
       polyglot.url = "github:ritzau/aoc-polyglot-languages";
       flake-utils.url = "github:numtide/flake-utils";
     };

     outputs = { self, polyglot, ... }:
       polyglot.lib.newlang.mkDefaultOutputs {
         inherit (self) description;
         src = ./.;
       };
   }
   ```

4. **Create source file** (hello.nl, main.newlang, etc.):

   ```newlang
   print("Hello, World from NewLang! 🌟")
   print("This is a hello world program for AOC polyglot setup.")
   ```

5. **Add direnv support**:

   ```bash
   echo "use flake" > .envrc
   ```

6. **Test**:

   ```bash
   nix build && nix run
   nix develop --command newlang --version
   ```

7. **Update documentation** in README.md

## Language-Specific Considerations

### Compiled Languages (C, C++, Rust, Go, Java, etc.)

- Source files should compile to executable with meaningful name
- Main function should demonstrate basic I/O
- Include common AOC libraries where applicable
- Test both build and run phases

### Interpreted Languages (Python, Ruby, Perl, PHP, etc.)

- Use standard file extensions and shebang lines
- Include example of importing common libraries
- Demonstrate version information where helpful
- Test interpreter availability in dev shell

### Functional Languages (Haskell, OCaml, Lisp, Elixir)

- Include basic function definitions
- Show common data structures (lists, maps)
- Demonstrate library imports where relevant
- Use language-specific build tools (cabal, opam, etc.)

## Version Management

### Language Version Overrides

Some languages support custom versions:

```nix
# Python 3.12 instead of default 3.11
polyglot.lib.python.mkDefaultOutputs {
  inherit (self) description;
  src = ./.;
  python = polyglot.inputs.nixpkgs.legacyPackages.x86_64-darwin.python312;
}

# JDK 17 instead of default 21
polyglot.lib.java.mkDefaultOutputs {
  inherit (self) description;
  src = ./.;
  jdk = polyglot.inputs.nixpkgs.legacyPackages.x86_64-darwin.jdk17;
}
```

**Current Limitation**: Version overrides require platform-specific package references. See [aoc-polyglot-languages#issues](https://github.com/ritzau/aoc-polyglot-languages/issues) for planned improvements.

### Dependency Updates

Update polyglot library version:

```bash
nix flake update polyglot
```

Update all dependencies:

```bash
nix flake update
```

## Testing Strategy

### Automated Testing

Future CI should verify:

1. All language examples build successfully
2. All language examples run and produce expected output
3. All dev environments provide expected tools
4. Cross-platform compatibility (macOS, Linux)
5. Documentation stays in sync with code

### Manual Testing Checklist

For each language example:

- [ ] `nix build` succeeds
- [ ] `nix run` produces "Hello, World from LANGUAGE!" output
- [ ] `nix develop` provides working language environment
- [ ] `nix flake check` passes all checks
- [ ] direnv integration works (if .envrc present)
- [ ] Language-specific tools available in dev shell

## Code Style and Conventions

### Nix Code Style

- Use nixfmt for formatting
- Prefer explicit imports over `with` statements
- Use descriptive names for let bindings
- Comment complex expressions
- Follow existing patterns in the codebase

### File Naming

- **Languages**: Use official language names (lowercase)
- **Source Files**: Use conventional extensions (.py, .java, .rs, etc.)
- **Scripts**: Use descriptive names matching package purpose

### Git Conventions

- **Commits**: Use conventional commits format
- **Branches**: Feature branches for new languages or improvements
- **PRs**: One language or feature per PR

## Troubleshooting

### Common Development Issues

**Flake evaluation errors**:

```bash
nix eval .#polyglot.lib --json  # Check polyglot library structure
nix flake show                  # Show all outputs
nix build --show-trace          # Detailed error information
```

**Build failures**:

```bash
nix log                         # Show build logs
nix develop --command which compiler  # Check tool availability
nix-shell -p compiler --run "compiler --version"  # Test compiler directly
```

**Environment issues**:

```bash
nix develop --command env | grep -i lang  # Check environment variables
direnv status                   # Check direnv state
direnv reload                   # Reload environment
```

### Platform-Specific Issues

**macOS**:

- Some languages may require Xcode command line tools
- Metal/OpenGL frameworks for graphics programming
- System Python conflicts with Nix Python

**Linux**:

- FHS compatibility for binary dependencies
- OpenGL/CUDA support for scientific computing
- glibc version compatibility

**Cross-compilation**:

- Not all languages support cross-compilation
- Some packages unavailable on all platforms
- Architecture-specific optimizations

## Documentation Standards

### README.md Updates

When adding new languages:

1. Add to "Supported Languages" list
2. Update examples section if needed
3. Add any language-specific notes
4. Update troubleshooting if common issues found

### Code Comments

- Explain non-obvious language-specific configuration
- Document version overrides and their rationale
- Clarify build system integration
- Note platform limitations

## Future Improvements

### Planned Features

1. **Cross-platform version overrides**: Function-based parameters for language versions
2. **Template generation**: `nix template` for new solution setup
3. **Benchmarking integration**: Built-in timing and comparison tools
4. **Testing framework**: Automated validation of solutions
5. **AOC integration**: Direct input fetching and submission tools

### Architecture Evolution

1. **Modular examples**: Separate basic vs advanced language examples
2. **Tool customization**: Per-language development tool selection
3. **Performance profiling**: Built-in profiling and optimization tools
4. **IDE integration**: LSP configuration for supported languages

## Contributing

### Pull Request Process

1. **Fork** the repository
2. **Create feature branch** from main
3. **Add/modify** language examples following established patterns
4. **Test** thoroughly on your platform
5. **Update documentation** as needed
6. **Submit PR** with clear description

### Review Criteria

PRs are reviewed for:

- Correctness of Nix flake configuration
- Following established file structure and naming
- Working examples that build and run
- Documentation updates where needed
- Cross-platform considerations

### Getting Help

- **Issues**: Report bugs or request features via GitHub issues
- **Discussions**: Use GitHub discussions for questions and ideas
- **Discord/Matrix**: Join Nix community channels for real-time help
