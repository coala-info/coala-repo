---
name: argutils
description: "argutils synchronizes command-line argument parsing with configuration file management using a single specification file. Use when user asks to define program interfaces, generate argparsers from specifications, or sync CLI flags with configuration files."
homepage: https://github.com/eclarke/argutils
---


# argutils

## Overview
`argutils` is a Python utility designed to bridge the gap between command-line argument parsing and configuration file management. It allows developers to define a program's interface in a single specification file, which is then used to programmatically generate an `argparse.ArgumentParser` and a corresponding `ConfigParser` file. This ensures that your application's parameters are consistent across all input methods and reduces the boilerplate code required to keep CLI flags and config files in sync.

## Implementation Workflow
1. **Define the Specification**: Create a specification file (JSON or YAML) that lists all program arguments. Each argument entry should include metadata such as help strings, default values, and expected data types.
2. **Generate the Parser**: Use `argutils.export.to_argparser()` within your Python script to transform the specification into a functional CLI.
3. **Load Configuration**: If a configuration file exists, use `argutils.set_parser_defaults()` to update the parser's default values with those found in the config file.
4. **Parse and Execute**: Call `parser.parse_args()` to retrieve the final values. The tool follows a strict precedence: command-line flags take top priority, followed by configuration file values, and finally the defaults defined in the specification.

## Tool-Specific Best Practices
- **Exclude Non-Persistent Arguments**: Use the `_exclude` attribute for arguments that are only relevant for a single execution, such as `--verbose`, `--version`, or `--init`. This prevents them from being written to the generated configuration file.
- **Automate Config Generation**: Implement an `--init` flag in your CLI that triggers `argutils.export.to_config_file()`. This allows users to easily generate a template configuration file populated with the default values from your specification.
- **Type Enforcement**: Explicitly define the `type` for each argument (e.g., `int`, `float`, or `File-w`) in the specification. `argutils` uses these to ensure the `argparse` object correctly validates user input.
- **Metadata for Help Text**: Use the `_meta` key in your specification to provide a global description for the program, which will appear in the CLI's help output and as a header in the generated config file.

## Expert Tips
- **Precedence Management**: Always call `set_parser_defaults` before calling `parse_args`. This ensures that the command line can still override values loaded from the disk.
- **File Handling**: Utilize specialized types like `File-w` (write) or `File-r` (read) in your specification to have `argutils` automatically handle file opening and permission checks via the underlying `argparse` logic.
- **Namespace Consistency**: Ensure the `prog_name` passed to the export functions matches the section header in your configuration file to maintain compatibility between the two systems.
- **Flag Arguments**: For boolean switches, set the `argtype` to `flag` in the specification to create a standard command-line toggle that does not require an additional value.

## Reference documentation
- [argutils README](./references/github_com_eclarke_argutils.md)