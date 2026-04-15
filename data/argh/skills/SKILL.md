---
name: argh
description: argh is a derive-based Rust library used to create lightweight command-line argument parsers with minimal binary overhead. Use when user asks to implement CLI argument parsing, define subcommands, or create lightweight command-line tools in Rust.
homepage: https://github.com/google/argh
metadata:
  docker_image: "quay.io/biocontainers/argh:0.26.2--py36_0"
---

# argh

## Overview
argh is an opinionated, derive-based argument parsing library for Rust, specifically optimized to minimize code size and binary bloat. It provides a streamlined alternative to heavier crates like clap by leveraging Rust's derive macros to transform structs and enums into fully functional CLI parsers. Use this skill to implement CLI logic that conforms to the Fuchsia command-line tools specification, ensuring your tools are lightweight, fast, and easy to maintain through declarative code.

## Implementation Patterns

### Basic CLI Structure
To create a basic CLI, define a struct and derive `FromArgs`. The doc comments on the struct and its fields are automatically used to generate the `--help` documentation.

```rust
use argh::FromArgs;

#[derive(FromArgs)]
/// Reach new heights with this CLI tool.
struct AppArgs {
    /// whether or not to jump
    #[argh(switch, short = 'j')]
    jump: bool,

    /// how high to go
    #[argh(option)]
    height: usize,

    /// an optional nickname
    #[argh(option)]
    nickname: Option<String>,
}

fn main() {
    let args: AppArgs = argh::from_env();
}
```

### Argument Types
*   **Switches**: Use `#[argh(switch)]` for boolean flags. They are optional by default and set to `true` if present.
*   **Options**: Use `#[argh(option)]` for arguments that take a value (e.g., `--name value`).
    *   Required: Use a direct type like `String` or `usize`.
    *   Optional: Wrap the type in `Option<T>`.
    *   Repeating: Wrap the type in `Vec<T>`.
*   **Positional**: Use `#[argh(positional)]`. These are parsed in the order they are declared in the struct. Only the last positional argument can be an `Option` or `Vec`.

### Default Values
Provide default values using a string containing Rust code that evaluates to the desired type.

```rust
#[derive(FromArgs)]
struct Config {
    /// port to listen on
    #[argh(option, default = "8080")]
    port: u16,

    /// custom greeting
    #[argh(option, default = "String::from(\"hello\")")]
    greeting: String,
}
```

### Subcommands
Handle complex CLI hierarchies by using an enum for subcommands. Each variant in the enum must point to a struct that also derives `FromArgs`.

```rust
#[derive(FromArgs)]
/// Top-level command.
struct Cli {
    #[argh(subcommand)]
    nested: Commands,
}

#[derive(FromArgs)]
#[argh(subcommand)]
enum Commands {
    Create(CreateArgs),
    Delete(DeleteArgs),
}

#[derive(FromArgs)]
/// Create a resource.
#[argh(subcommand, name = "create")]
struct CreateArgs {
    #[argh(option)]
    /// name of the resource
    name: String,
}
```

### Custom Parsing
For types that don't implement `FromStr`, or when specific validation is needed, use `from_str_fn`.

```rust
fn parse_hex(value: &str) -> Result<u32, String> {
    u32::from_str_radix(value, 16).map_err(|e| e.to_string())
}

#[derive(FromArgs)]
struct HexTool {
    /// a hex value to process
    #[argh(option, from_str_fn(parse_hex))]
    value: u32,
}
```

## Expert Tips
*   **Binary Size**: argh is significantly smaller than clap. If your binary size is a critical metric (e.g., for small containers or embedded tools), argh is the preferred choice.
*   **Help Triggers**: By default, argh responds to `--help`. You can customize help behavior or triggers if the `help` feature is enabled in your `Cargo.toml`.
*   **Fuchsia Conformance**: argh enforces a specific CLI style (e.g., no grouped short flags like `-abc`). Stick to the standard long-form options for the best user experience.
*   **Debugging Macros**: If the derive macro is failing or behaving unexpectedly, use `cargo expand` (requires nightly) to see the generated code for the `FromArgs` implementation.

## Reference documentation
- [Argh README and Examples](./references/github_com_google_argh.md)