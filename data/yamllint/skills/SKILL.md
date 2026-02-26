---
name: yamllint
description: yamllint checks YAML files for syntax errors and style violations. Use when user asks to lint YAML files, check YAML syntax, enforce style guidelines, detect issues like improper indentation, configure linting rules, or ignore specific files or rules.
homepage: https://github.com/adrienverge/yamllint
---


# yamllint

## Overview
yamllint is a specialized tool designed to verify that YAML files are not only syntactically correct but also follow best practices for readability and maintainability. Unlike basic parsers, it detects subtle issues such as key repetition, improper indentation, trailing spaces, and excessive line lengths. This skill provides the necessary command-line patterns and configuration strategies to integrate yamllint into development workflows and automated pipelines.

## Command Line Usage

### Basic Linting
- **Single file**: Run `yamllint <filename>` to check a specific file.
- **Multiple files**: Pass multiple paths like `yamllint file1.yaml file2.yml`.
- **Directory-wide**: Use `yamllint .` to recursively check all YAML files in the current directory and its subdirectories.

### Configuration Presets
yamllint comes with built-in configurations that can be toggled via the `-d` (data) flag:
- **Default**: Strict adherence to standard YAML practices.
- **Relaxed**: A more lenient set of rules, useful for legacy projects or less formal configurations.
  - Example: `yamllint -d relaxed file.yaml`

### Custom Configuration
- **External config**: Use the `-c` flag to point to a specific configuration file: `yamllint -c /path/to/myconfig.yaml file.yaml`.
- **Inline config**: You can pass a configuration string directly using the `-d` flag: `yamllint -d "{extends: default, rules: {line-length: {max: 120}}}" file.yaml`.

### Output Formats
- **Standard**: Human-readable output showing line, column, level (error/warning), and rule violated.
- **Parsable**: Use `-f parsable` to generate output compatible with external tools like Vim, Emacs, or CI log parsers.

## Expert Tips and Best Practices

### Inline Disabling
When a specific line or block must violate a rule (e.g., a long URL that breaks line-length limits), use comments to control the linter:
- To ignore a single line, append a comment starting with `yamllint disable-line`.
- To ignore a block, wrap the content with `yamllint disable rule:rule-name` and `yamllint enable`.

### Handling Large Projects
- **Ignore Patterns**: Use the `ignore` key in your configuration file to skip specific files or directories using `.gitignore` style patterns.
- **CI Integration**: Always use the default output or parsable format in CI scripts to ensure failures are clearly attributed to specific lines.

### Common Rule Adjustments
- **Indentation**: If your project uses a specific number of spaces (e.g., 2 vs 4), ensure the `indentation` rule is explicitly set in your config to avoid "wrong indentation" errors.
- **Truthiness**: yamllint often flags ambiguous boolean values. Use the `truthiness` rule to enforce consistent usage of `true`/`false` over `yes`/`no`.

## Reference documentation
- [yamllint Main Documentation](./references/github_com_adrienverge_yamllint.md)