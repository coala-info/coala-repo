---
name: igor
description: Igor is a language-agnostic shebang interpreter that automatically compiles and executes single-file programs written in compiled languages. Use when user asks to create scripts from templates, run compiled languages like Rust or C++ as single-file scripts, manage script caches, or automate build instructions within source files.
homepage: https://github.com/igor-petruk/scriptisto
metadata:
  docker_image: "biocontainers/igor:v1.3.0dfsg-1-deb_cv1"
---

# igor

## Overview
The `igor` skill (utilizing the `scriptisto` tool) enables a "scripting" experience for compiled languages. It functions as a language-agnostic shebang interpreter that extracts build instructions directly from comments within a source file. Upon execution, it automatically handles compilation, caches the resulting binary, and delegates execution with minimal overhead. This allows for the distribution of single-file programs that benefit from the performance and type safety of languages like Rust or C++ without requiring the user to manually manage build systems.

## Usage and Best Practices

### Creating New Scripts
The most efficient way to start is by using built-in templates.
- **List available templates**: `scriptisto template list`
- **Generate a script from a template**: `scriptisto new <template_name> > my_script.ext`
- **Common templates**: `rust`, `c`, `cpp`, `go`, `haskell`.

### Script Structure
Every script must include a shebang and a metadata block.
1. **Shebang**: The first line must be `#!/usr/bin/env scriptisto`.
2. **Build Block**: Instructions must be wrapped between `scriptisto-begin` and `scriptisto-end` markers within the language's comment syntax.
3. **Required Metadata**:
   - `script_src`: The filename the source should be saved as during the build process (e.g., `main.rs`).
   - `build_cmd`: The exact command used to compile the source into an executable named `script`.

### CLI Operations
- **Execution**: Once the script is marked as executable (`chmod +x script.ext`), run it directly: `./script.ext`.
- **Forced Rebuild**: If you need to ensure a fresh build without changing the source, use: `scriptisto build script.ext`.
- **Cache Management**: `scriptisto` stores binaries in a cache directory (usually `~/.cache/scriptisto`). Use `scriptisto clean` to remove old builds.

### Expert Tips
- **Dockerized Builds**: You can perform builds inside a Docker container by specifying a `build_cmd` that invokes `docker run`. This is useful for building static binaries without installing compilers on the host system.
- **Dependency Management**: For Rust scripts, use `cargo` within the `build_cmd`. You can define a small `Cargo.toml` inline or via a heredoc in the build command to fetch dependencies automatically.
- **Performance**: The overhead for an already-built script is less than 1ms, making it suitable for CLI tools and system utilities where latency matters.
- **Type Checking**: For interpreted languages like Python, use this tool to run slow static analysis (like `mypy`) only when the file changes, caching the "validated" state.

## Reference documentation
- [Scriptisto Main Repository](./references/github_com_igor-petruk_scriptisto.md)
- [Scriptisto Wiki](./references/github_com_igor-petruk_scriptisto_wiki.md)