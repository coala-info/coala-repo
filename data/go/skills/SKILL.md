---
name: go
description: This tool provides a specialized guide for the Go programming language ecosystem, including library selection and core CLI workflows. Use when user asks to initialize modules, manage dependencies, build or test applications, and find libraries for CLI development, AI, or distributed systems.
homepage: https://github.com/avelino/awesome-go
metadata:
  docker_image: "quay.io/biocontainers/go:1.11.3"
---

# go

## Overview
This skill serves as a specialized guide for the Go programming language ecosystem. It helps you navigate the vast landscape of Go libraries and tools—ranging from actor models and AI frameworks to advanced console UIs and blockchain implementations. Use this skill to identify the most appropriate "Awesome Go" resources for your specific use case and to implement standard Go development workflows efficiently.

## Core CLI Workflows

### Project Initialization
Always use Go modules for dependency management.
- Initialize a new module: `go mod init <module-name>`
- Tidy dependencies (remove unused, add missing): `go mod tidy`
- Verify dependency integrity: `go mod verify`

### Development and Building
- Run the current package: `go run .`
- Compile the package: `go build -o <binary-name>`
- Run tests with verbose output: `go test -v ./...`
- Check for race conditions: `go test -race ./...`

## Library Selection Guide
When choosing libraries from the Awesome Go collection, prioritize those that align with your architectural needs:

### CLI and Terminal UIs
- **Modern CLI Frameworks**: Use `cobra` for complex applications with subcommands or `urfave/cli` for simpler, faster builds.
- **Interactive TUIs**: Use `bubbletea` (The Elm Architecture) for complex interactive apps or `pterm` for beautiful, easy-to-use console components.
- **Styling**: Use `lipgloss` for declarative terminal styling and `color` for simple ANSI output.

### Specialized Domains
- **Artificial Intelligence**: Use `langchaingo` for LLM orchestration or `ollama` for running local models.
- **Actor Model**: Use `ProtoActor` for distributed systems or `Hollywood` for lightweight, high-performance local actors.
- **Authentication**: Use `casbin` for flexible authorization (RBAC/ABAC) and `goth` for multi-provider OAuth/OAuth2.
- **Data Structures**: Use `gods` for a comprehensive collection of containers or `roaring` for high-performance compressed bitsets.

## Expert Tips
- **Live Reloading**: During development, use `air` to automatically rebuild and restart your application on file changes.
- **Task Automation**: Replace complex Makefiles with `mage` (Go-based build tool) or `task` (simple YAML-based alternative) for more idiomatic task running.
- **Minimalism**: Before adding a heavy dependency, check if the task can be accomplished using the Go Standard Library, which is exceptionally robust for networking, I/O, and concurrency.
- **Performance**: For performance-critical bit-packing, look into `bitmap` for SIMD-enabled operations.



## Subcommands

| Command | Description |
|---------|-------------|
| go | A collection of tools for Go development. |
| go | Go is a tool for managing Go source code. |
| go build | Builds the specified packages and their dependencies. |
| go clean | Run 'go help clean' for details. |
| go doc | Display documentation for Go packages and symbols. |
| go fix | Run 'go help fix' for details. |
| go fmt | Format Go programs |
| go generate | Run 'go help generate' for details. |
| go get | Run 'go help get' for details. |
| go install | Install packages and dependencies |
| go list | List packages or modules |
| go mod | Provides access to operations on modules. |
| go run | Run a Go program |
| go test | Build and test Go packages |
| go_bug | Please file a new issue at golang.org/issue/new using this template: |
| go_env | Prints Go runtime environment information. |

## Reference documentation
- [Awesome Go Actor Model](./references/awesome-go_com_actor-model.md)
- [Awesome Go Advanced Console UIs](./references/awesome-go_com_advanced-console-uis.md)
- [Awesome Go Artificial Intelligence](./references/awesome-go_com_artificial-intelligence.md)
- [Awesome Go Authentication and Authorization](./references/awesome-go_com_authentication-and-authorization.md)
- [Awesome Go Build Automation](./references/awesome-go_com_build-automation.md)
- [Awesome Go Command Line](./references/awesome-go_com_command-line.md)
- [Awesome Go Data Structures](./references/awesome-go_com_data-structures-and-algorithms.md)