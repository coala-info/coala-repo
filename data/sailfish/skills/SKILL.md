---
name: sailfish
description: Sailfish is a high-performance template engine for Rust that compiles templates into code for type safety and speed. Use when user asks to generate Rust template structs, write .stpl files, or choose rendering traits for performance requirements.
homepage: https://github.com/rust-sailfish/sailfish
metadata:
  docker_image: "quay.io/biocontainers/sailfish:0.10.1--1"
---

# sailfish

## Overview
Sailfish is a template engine for Rust designed for extreme speed and simplicity. It works by compiling templates into Rust code during the build process, ensuring type safety and minimal runtime overhead. Use this skill to generate Rust template structs, write `.stpl` files, and choose the appropriate rendering trait for your performance requirements.

## Implementation Patterns

### Choosing a Trait
*   **TemplateSimple**: Use for maximum performance when you only need to access struct fields directly. It provides the fastest rendering path.
*   **Template / TemplateOnce**: Use when the template needs to call methods on the struct (`self.method()`) or requires more complex logic.

### Template Syntax
Sailfish uses syntax inspired by EJS:
*   `<% rust_code %>`: Execute arbitrary Rust code (loops, conditionals).
*   `<%= expression %>`: Evaluate and render an escaped expression.
*   `<%- expression %>`: Render an unescaped (raw) expression.
*   `<%# comment %>`: Template comments.
*   `<% include!("path/to/file.stpl") %>`: Include another template file.

### Macro Configuration
Apply the `#[derive(Template)]` or `#[derive(TemplateSimple)]` macro to your data struct.
```rust
#[derive(Template)]
#[template(path = "hello.stpl")]
struct MyTemplate {
    messages: Vec<String>
}
```
The `path` is relative to the `templates` directory by default.

## Best Practices
*   **Directory Structure**: Place your `.stpl` files in a `templates/` folder at the root of your crate to follow standard conventions.
*   **Method Calls**: When using the `Template` trait, ensure methods called within the template take `&self` or `&mut self` as appropriate.
*   **Error Handling**: Always handle the `Result` returned by `.render()` or `.render_once()` to catch potential rendering issues.
*   **MSRV**: Ensure your project uses Rust 1.89 or later.
*   **Direct Rendering**: For `TemplateSimple`, fields are accessed directly (e.g., `<%= msg %>`). For `Template`, fields must be accessed via self (e.g., `<%= self.msg %>`).

## Reference documentation
- [Sailfish README](./references/github_com_rust-sailfish_sailfish.md)