---
name: involucro
description: Involucro builds and packages software using containers driven by a Lua-based configuration file. Use when user asks to build software in ephemeral containers, package artifacts into minimal production images, or define containerized build tasks using Lua.
homepage: https://github.com/involucro/involucro
metadata:
  docker_image: "quay.io/biocontainers/involucro:1.1.2--0"
---

# involucro

## Overview

Involucro is a specialized tool for building and packaging software using containers, driven by a Lua-based configuration file (`invfile.lua`). It treats containers as ephemeral workers to transform source code and then "wraps" the resulting artifacts into clean, minimal production images. By separating the build process from the deliverable, it allows for sophisticated caching, multi-container orchestration, and precise control over the final image structure.

## Core Concepts and Syntax

### The invfile.lua
All logic resides in `invfile.lua`. Tasks are defined using a fluent API.

```lua
-- Example: Defining a task that compiles and then packages
inv.task('build')
  .using('gcc:9')
  .run('gcc', '-o', 'hello', 'hello.c')

inv.task('package')
  .wrap('.')
  .at('/usr/local/bin')
  .inImage('alpine:latest')
```

### Run Steps
Used to execute a process inside a container. By default, the current directory is mounted to `/source`.

- **`task.using('<image>')`**: Specifies the build environment.
- **`runstep.withConfig(<table>)`**: Sets container-specific options (e.g., `Env`, `User`).
- **`runstep.withHostConfig(<table>)`**: Sets host-level options (e.g., `Binds`, `Links`, `PortBindings`).
- **`runstep.withExpectation(<table>)`**: Validates the outcome.
  - `code`: Expected exit code (default 0).
  - `stdout` / `stderr`: Re2 regular expression to match output.
- **`runstep.run('<cmd>', ...)`**: The command to execute.

### Wrap Steps
Used to create a new image from a directory.

- **`task.wrap('<dir>')`**: Source directory for the new layer.
- **`wrapstep.at('<target>')`**: Destination path inside the image.
- **`wrapstep.inImage('<parent>')`**: The base image to build upon.
- **`wrapstep.withConfig(<table>)`**: Set metadata like `Entrypoint`, `Cmd`, or `ExposedPorts`.

## Common CLI Patterns

- **Run specific tasks**: `involucro <task_name>`
- **Run multiple tasks in order**: `involucro clean build package`
- **Custom configuration file**: `involucro -f my_config.lua <task>`
- **Verbose output**: `involucro -v <task>` (useful for debugging container execution)

## Expert Tips and Best Practices

1. **Modular Steps**: Store step configurations in Lua variables to reuse them across different tasks.
   ```lua
   local compiler = inv.task('compile').using('golang:1.18')
   compiler.run('go', 'build', '-o', 'app')
   ```
2. **Relative Binds**: When using `withHostConfig`, Involucro automatically converts relative paths in `Binds` to absolute paths. Use `{binds = {"./dist:/data"}}` for portability.
3. **Shell Execution**: `runstep.run` does not expand wildcards or variables by default. To use shell features, wrap the command:
   `runstep.run('/bin/sh', '-c', 'echo $MY_VAR > output.txt')`
4. **Clean Deliverables**: Always use a `wrap` step with a minimal base image (like `alpine` or `scratch`) to ensure the final image does not contain build-time dependencies or source code.
5. **Expectation Testing**: Use `withExpectation` in your CI tasks to ensure that your build process not only finishes but produces the expected log output.

## Reference documentation
- [Involucro Main Documentation](./references/github_com_involucro_involucro.md)