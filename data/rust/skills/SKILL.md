---
name: rust
description: Rust is a systems programming language designed for performance, reliability, and productivity.
homepage: https://github.com/rust-lang/rust
---

# rust

## Overview
Rust is a systems programming language designed for performance, reliability, and productivity. It achieves memory safety without a garbage collector through its unique ownership system. This skill facilitates the use of the standard Rust toolchain—specifically Cargo for package management and building, Clippy for linting, and rustfmt for consistent styling. It also covers the internal build procedures for the Rust compiler itself, utilizing the `x.py` entry point found in the core repository.

## Core Toolchain Usage

### Cargo (Package Manager & Build Tool)
Cargo is the primary interface for Rust development.
- **Initialize a project**: `cargo new <project-name>` (binary) or `cargo new --lib <project-name>` (library).
- **Fast compilation check**: `cargo check`. Use this during active development to catch type errors without the overhead of full code generation.
- **Build for development**: `cargo build`.
- **Build for production**: `cargo build --release`. This enables heavy optimizations; always use this flag for benchmarks or deployment.
- **Run tests**: `cargo test`. This runs unit tests, integration tests, and documentation examples.
- **Update dependencies**: `cargo update` (updates `Cargo.lock` within semver constraints).

### Code Quality & Formatting
- **Linting**: `cargo clippy`. Use this to catch common mistakes and improve idiomatic code quality.
- **Formatting**: `cargo fmt`. Ensures the project adheres to the standard Rust style guide.
- **Documentation**: `cargo doc --open`. Generates and opens local HTML documentation for the project and all dependencies.

## Compiler Development Patterns
When working directly with the `rust-lang/rust` source code:
- **The Build Script**: Use the `x.py` (or `x.ps1` on Windows) script located in the root directory.
- **Build the compiler**: `python x.py build`.
- **Run compiler tests**: `python x.py test`.
- **Configuration**: Copy `config.example.toml` to `config.toml` to customize the build (e.g., enabling debug assertions or changing the install prefix).

## Expert Tips
- **Diagnostic Interpretation**: Rust compiler errors are highly descriptive. Always look for the "help" or "suggestion" sections in the CLI output, as they often provide the exact code fix.
- **Dependency Management**: Check `Cargo.toml` for feature flags. Many Rust crates use features to keep the dependency tree lean; enable only what is necessary.
- **Toolchain Management**: Use `rustup` to manage versions. Switch to `nightly` only when specific unstable features (e.g., `trait_alias`, `adt_const_params`) are required for experimental development.
- **Performance Profiling**: When investigating "Internal Compilation Errors" (ICE) or slow builds, use `-Z self-profile` (nightly) to identify which compiler passes are the bottleneck.

## Reference documentation
- [Rust Repository Overview](./references/github_com_rust-lang_rust.md)
- [Security Policy](./references/github_com_rust-lang_rust_security.md)
- [Issue Tracking](./references/github_com_rust-lang_rust_issues.md)