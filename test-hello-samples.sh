#!/bin/bash

# Script to test hello samples after aoc-polyglot-languages update
set -e

SAMPLES_DIR="/Users/ritzau/src/slask/aoc/aoc-nix/src/hello"
LANGUAGES=("python" "rust" "c" "java" "go" "javascript" "haskell")

echo "=== Testing Hello Samples ==="
echo "Testing directory: $SAMPLES_DIR"
echo ""

for lang in "${LANGUAGES[@]}"; do
    echo "=== Testing $lang ==="
    cd "$SAMPLES_DIR/$lang"

    echo "Files in directory:"
    ls -la
    echo ""

    # Test 1: nix build
    echo "Testing 'nix build'..."
    if nix build --show-trace 2>&1; then
        echo "✓ nix build: SUCCESS"
    else
        echo "✗ nix build: FAILED"
        echo "Error details:"
        nix build --show-trace 2>&1 || true
    fi
    echo ""

    # Test 2: nix develop
    echo "Testing 'nix develop'..."
    if timeout 30 nix develop -c echo "Development shell works" 2>&1; then
        echo "✓ nix develop: SUCCESS"
    else
        echo "✗ nix develop: FAILED"
        echo "Error details:"
        timeout 30 nix develop -c echo "Development shell works" 2>&1 || true
    fi
    echo ""

    # Test 3: Check for .cache directory
    echo "Checking for .cache directory and symlinks..."
    if [ -d ".cache" ]; then
        echo "✓ .cache directory exists"
        echo "Contents of .cache:"
        ls -la .cache/
        if [ -f ".cache/$lang.justfile" ]; then
            echo "✓ .cache/$lang.justfile exists"
        else
            echo "✗ .cache/$lang.justfile missing"
        fi
    else
        echo "✗ .cache directory missing"
        echo "Creating .cache directory and testing nix develop to see if it gets populated..."
        mkdir -p .cache
        timeout 30 nix develop -c echo "Testing cache creation" 2>&1 || true
        if [ -f ".cache/$lang.justfile" ]; then
            echo "✓ .cache/$lang.justfile created after nix develop"
        else
            echo "✗ .cache/$lang.justfile still missing after nix develop"
        fi
    fi
    echo ""

    # Test 4: justfile commands (if possible)
    echo "Testing justfile commands..."
    if command -v just >/dev/null 2>&1; then
        if timeout 30 nix develop -c just --list 2>&1; then
            echo "✓ justfile: SUCCESS"
            echo "Available commands:"
            timeout 30 nix develop -c just --list 2>&1 || true
        else
            echo "✗ justfile: FAILED"
            echo "Error details:"
            timeout 30 nix develop -c just --list 2>&1 || true
        fi
    else
        echo "⚠ just command not available outside nix develop"
        echo "Testing just inside nix develop:"
        timeout 30 nix develop -c sh -c 'if command -v just >/dev/null 2>&1; then just --list; else echo "just not available in dev shell"; fi' 2>&1 || true
    fi

    echo ""
    echo "=== End of $lang test ==="
    echo ""
done

echo "=== Test Summary ==="
echo "All tests completed. Check the output above for details."
