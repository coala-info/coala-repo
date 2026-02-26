---
name: perl-test-harness
description: This tool executes and interprets tests that communicate via the Test Anything Protocol (TAP). Use when user asks to run tests with prove, execute tests in parallel, or interpret TAP-compliant test output.
homepage: http://testanything.org/
---


# perl-test-harness

## Overview
The `perl-test-harness` skill enables the execution and interpretation of tests that communicate via the Test Anything Protocol (TAP). While originally developed for Perl, this tool serves as a universal consumer for any test producer that outputs TAP-compliant text. Use this skill to orchestrate test runs, manage test dependencies (like "Bail out!" commands), and ensure that test results are accurately reported across different environments.

## Core Usage Patterns

### Running Tests with `prove`
The primary command-line interface for `perl-test-harness` is the `prove` utility.

- **Run all tests in a directory**: `prove -r t/`
- **Run tests in parallel**: `prove -j 9` (where 9 is the number of CPU cores/threads).
- **Verbose output**: `prove -v t/test_file.t` (shows individual `ok`/`not ok` lines).
- **Shuffle test order**: `prove --shuffle` (helps identify hidden dependencies between test files).
- **State persistence**: `prove --state=save` (saves results to allow running only failed tests next time with `prove --state=failed`).

### Interpreting TAP Output
When analyzing raw test output or debugging a producer, look for these structural elements:

- **The Plan**: `1..N` (e.g., `1..4`). This must appear at the beginning or end to ensure the test didn't crash mid-run.
- **Test Lines**: Must start with `ok` or `not ok`.
- **Directives**: 
  - `# SKIP`: Used when a test cannot run (e.g., missing dependency).
  - `# TODO`: Used for known bugs; a "not ok" with TODO is treated as a pass by the harness.
- **Bail out!**: If a test outputs `Bail out!`, the harness will stop all remaining tests immediately.

### Version Specifics
- **TAP 13/14**: Requires an explicit header: `TAP version 13` or `TAP version 14`.
- **YAML Blocks**: In versions 13 and 14, detailed failure data is contained between `---` and `...` markers immediately following a `not ok` line.

## Expert Tips
- **Standard Error**: The harness typically ignores `STDERR`. If you need to see debug prints, ensure the producer prefixes them with `#` to be treated as diagnostics, or use `prove -v`.
- **Non-Perl Producers**: You can run tests written in any language through `prove` as long as they print TAP to `STDOUT`. Use `prove --exec "python3" t/test.py`.
- **Exit Codes**: A test script is considered failed if it has a non-zero exit code, even if all individual TAP lines were `ok`.

## Reference documentation
- [TAP specification](./references/testanything_org_tap-specification.html.md)
- [TAP 13 specification](./references/testanything_org_tap-version-13-specification.html.md)
- [TAP 14 specification](./references/testanything_org_tap-version-14-specification.html.md)
- [TAP Consumers](./references/testanything_org_consumers.html.md)