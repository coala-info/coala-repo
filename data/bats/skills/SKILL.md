---
name: bats
description: Bats is a testing framework for Bash that provides a simple way to verify the behavior of UNIX programs and shell scripts. Use when user asks to write automated tests for CLI applications, verify command exit statuses, or run test suites for system integrations.
homepage: https://github.com/sstephenson/bats
metadata:
  docker_image: "quay.io/biocontainers/bats:0.4.0--0"
---

# bats

## Overview
Bats (Bash Automated Testing System) is a testing framework that provides a simple way to verify that UNIX programs behave as expected. A Bats test file is essentially a Bash script with a specialized syntax for defining test cases. It operates on the principle that every command in a test case is an assertion; if any command exits with a non-zero status, the test fails. This makes it an ideal tool for testing shell scripts, CLI applications, and system integrations.

## Test Syntax and Structure
Tests are defined using the `@test` keyword followed by a description and a block of code.

```bash
#!/usr/bin/env bats

@test "check that grep finds a string" {
  run grep -q "hello" <<< "hello world"
  [ "$status" -eq 0 ]
}
```

### The `run` Helper
The `run` command is the most critical helper in Bats. It executes a command and captures its results into global variables without failing the test immediately if the command returns a non-zero exit code.
- `$status`: The exit status of the command.
- `$output`: The combined stdout and stderr.
- `${lines[n]}`: An array where each element is a line of the output.

### Lifecycle Hooks
- `setup()`: Runs before every test case. Use this to create temporary directories or initialize environment variables.
- `teardown()`: Runs after every test case. Use this to clean up files or kill background processes.

### Common Helpers
- `load`: Sources a Bash file relative to the test file. Useful for sharing helper functions across multiple `.bats` files.
- `skip`: Skips a test. Can be used conditionally (e.g., `if [ "$IS_MAC" ]; then skip; fi`).

## CLI Usage Patterns
- **Run a single file**: `bats test_file.bats`
- **Run a directory of tests**: `bats test/`
- **CI/Machine-readable output**: `bats --tap test_file.bats` (Produces Test Anything Protocol output).

## Expert Tips
- **Debugging**: Since Bats captures stdout for TAP compliance, any debugging print statements in your code must be redirected to stderr (e.g., `echo "debug" >&2`) to be visible during execution.
- **File Isolation**: Use the `$BATS_TMPDIR` variable to create temporary files. This ensures tests don't collide when run in parallel or on shared systems.
- **Strict Assertions**: While `[ "$status" -eq 0 ]` is common, you can use standard Bash conditional expressions to check for file existence (`[ -f file ]`), string matches (`[[ "$output" =~ "regex" ]]`), or non-empty strings.
- **External Dependencies**: Use the code outside of `@test` functions to check for required binaries and exit early if they are missing.
- **Note on Maintenance**: The original `sstephenson/bats` repository is archived. For modern features and active maintenance, the community generally uses the `bats-core` fork, though the syntax remains compatible.

## Reference documentation
- [Bats README](./references/github_com_sstephenson_bats.md)
- [Bats Wiki](./references/github_com_sstephenson_bats_wiki.md)