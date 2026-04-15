---
name: weeder
description: Weeder is a static analysis tool for Haskell that detects unreachable code. Use when user asks to find unused Haskell code, identify dead code in a Haskell project, or generate a default configuration.
homepage: https://github.com/ocharles/weeder
metadata:
  docker_image: "quay.io/biocontainers/weeder:2.0--h9948957_10"
---

# weeder

## Overview

Weeder is a specialized static analysis tool for Haskell that detects "weeds"—code that is defined but never reachable from specified entry points (roots). While GHC provides module-local warnings for unused code, Weeder performs whole-program analysis by traversing a dependency graph built from GHC-generated `.hie` files. This allows it to find code that is exported but never actually imported or used by any other part of the application or test suite.

## Preparation

To use Weeder, you must first configure GHC to produce `.hie` files, which contain the symbol resolution and type information Weeder requires.

### For Cabal Projects
Add the following to your `cabal.project.local`:
```text
program-options
  ghc-options: -fwrite-ide-info
```
Then perform a full rebuild:
```bash
cabal clean
cabal build all
```

### For Stack Projects
Add the following to your `stack.yaml`:
```yaml
ghc-options:
  "$locals": -fwrite-ide-info
```
Then rebuild:
```bash
stack clean
stack build
```

## Configuration (weeder.toml)

Weeder requires a `weeder.toml` file in the project root to define what code is considered "alive."

### Common Configuration Patterns
```toml
# Define entry points for the analysis
roots = [
  "^Main.main$",          # Standard executable entry point
  "^Paths_.*",            # Ignore Cabal-generated Paths modules
  "MyLibrary.Public.API"  # Specific public API modules
]

# Handle type classes
type-class-roots = true   # Consider all instances as roots (prevents flagging instances as dead)

# Mark specific modules as roots (all exports considered alive)
root-modules = [ "^MyProject\\.Public\\..*$" ]

# Enable analysis for unused types (disabled by default)
unused-types = true
```

## CLI Usage and Patterns

### Basic Execution
Run the tool from the project root:
```bash
weeder
```

### Initialization
If no configuration exists, generate a default one:
```bash
weeder --write-default-config
```

### CI Integration
Weeder uses specific exit codes that are useful for CI/CD pipelines:
- **0**: No weeds found.
- **228**: One or more weeds found (use this to fail a build).
- **2**: GHC version mismatch (HIE files incompatible).
- **4**: No HIE files found (check build step).

### Strict Configuration
To ensure your configuration is explicit and not relying on hidden defaults:
```bash
weeder --no-default-fields
```

## Expert Tips and Limitations

- **Template Haskell**: Weeder cannot parse the results of Template Haskell splices. If TH code refers to other symbols, Weeder may report those symbols as dead (false positives). Manually add these to `roots` in `weeder.toml`.
- **Overloaded Syntax**: Symbols used only via overloaded literals (like `fromInteger` for `Num` or `fromString` for `IsString`) might be flagged as weeds on some GHC versions. Use `type-class-roots = true` or specific `root-instances` to mitigate this.
- **Type Families**: Weeder currently marks type family instances as implicit roots when `unused-types` is enabled because it cannot yet fully analyze their usage.
- **Dead Instances**: To find unused type class instances in a specific module `M`, add `{ module = "^M$" }` to `root-instances`.

## Reference documentation
- [Weeder Main Documentation](./references/github_com_ocharles_weeder.md)