---
name: sbt
description: sbt is the standard interactive build tool for Scala and Java projects.
homepage: https://github.com/sbt/sbt
---

# sbt

## Overview

sbt is the standard interactive build tool for Scala and Java projects. It utilizes the Zinc incremental compiler to minimize recompilation times and provides a powerful, stateful shell for rapid development. This skill focuses on navigating the sbt CLI, managing multi-module builds, and utilizing advanced features like pipelining and the thin client (sbtn) to improve developer productivity.

## Core CLI Usage

### Interactive vs. Batch Mode
- **Interactive Shell**: Run `sbt` without arguments to enter the shell. This is preferred for development as it keeps the JVM warm and caches build state.
- **Batch Mode**: Run `sbt <command>` for one-off tasks (e.g., `sbt clean compile`).
- **Continuous Execution**: Prefix any command with `~` (e.g., `~test`) to automatically re-run the task whenever source files change.

### Common Tasks
- `compile`: Compile the main sources.
- `test`: Run all tests.
- `testOnly <test-name>`: Run a specific test suite (supports wildcards, e.g., `testOnly *UserSpec`).
- `run`: Run the main class for the project.
- `console`: Start a Scala REPL with the project's dependencies on the classpath.
- `clean`: Delete all generated files (target directory).
- `reload`: Reload the build definition (`build.sbt` and `project/*.scala` files).

## Project Navigation and Inspection

### Multi-Module Projects
- `projects`: List all sub-projects defined in the build.
- `project <project-id>`: Switch the current context to a specific sub-project.
- `<project-id>/<task>`: Run a task for a specific project without switching context (e.g., `core/compile`).

### Inspecting the Build
- `inspect <key>`: View detailed information about a setting or task, including its dependencies and where it is defined.
- `show <key>`: Display the current value of a setting (e.g., `show libraryDependencies`).
- `last <task>`: View the full stack trace or detailed log output of the last failed execution of a task.
- `export <task>`: Show the equivalent command-line arguments for a task (useful for debugging classpaths).

## Performance and Advanced Features

### sbt 2.x and Pipelining
- **Pipelining**: Enable `usePipelining := true` in your build to allow downstream projects to start compiling as soon as upstream signatures are ready, rather than waiting for full JAR creation.
- **Thin Client (sbtn)**: Use the `sbtn` executable instead of `sbt` to connect to an existing server instance instantly, avoiding the overhead of JVM startup.

### Dependency Management
- `dependencyTree`: Visualize the project's dependency graph to identify version conflicts.
- `update`: Force a resolution of library dependencies.
- `evicted`: Show which dependencies were replaced by newer versions.

### Debugging and Logging
- `set <setting> := <value>`: Temporarily change a setting in the current session (e.g., `set logLevel := Level.Debug`).
- `lastGrep <pattern> <task>`: Search the logs of the last task execution for a specific pattern.

## Best Practices
- **Use the Shell**: Avoid running `sbt compile` repeatedly from the terminal; stay inside the sbt shell to benefit from the "warm" compiler.
- **Scope Tasks**: Be specific with scopes when necessary (e.g., `Test / compile` vs `Compile / compile`) to avoid unnecessary work.
- **Global Plugins**: Place cross-project tools in `~/.sbt/1.0/plugins/` (for sbt 1.x) or the equivalent 2.x directory to keep project-specific builds clean.

## Reference documentation
- [sbt README](./references/github_com_sbt_sbt.md)
- [sbt Developer Wiki](./references/github_com_sbt_sbt_wiki.md)
- [sbt Issues and Known Behaviors](./references/github_com_sbt_sbt_issues.md)