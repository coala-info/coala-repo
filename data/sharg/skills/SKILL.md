---
name: sharg
description: Sharg is a C++20 header-only library designed to simplify the creation of robust command-line interfaces (CLIs).
homepage: https://github.com/seqan/sharg-parser
---

# sharg

## Overview
Sharg is a C++20 header-only library designed to simplify the creation of robust command-line interfaces (CLIs). It eliminates the boilerplate associated with manual `argc` and `argv` parsing by mapping command-line inputs directly to C++ variables. Beyond simple parsing, it automatically generates professional help menus, handles versioning, and supports advanced features like subcommands and documentation export.

## Implementation Patterns

### Basic Parser Setup
Initialize the parser with the application name and the standard command-line arguments. The `parse()` method should be called after all options are defined.

```cpp
#include <sharg/all.hpp>

int main(int argc, char ** argv) {
    sharg::parser parser{"my-tool", argc, argv};
    // Define options and flags here
    parser.parse();
    return 0;
}
```

### Defining Options and Flags
Use `sharg::config` to define the metadata for your arguments.
- **Options**: Used for arguments that require a value (e.g., `--threads 8`).
- **Flags**: Used for boolean toggles (e.g., `--verbose`).

```cpp
int threads{1};
bool verbose{false};

parser.add_option(threads, sharg::config{.short_id = 't', .long_id = "threads", .description = "Number of threads to use."});
parser.add_flag(verbose, sharg::config{.short_id = 'v', .long_id = "verbose", .description = "Enable verbose logging."});
```

### Organizing the Help Page
For tools with many options, use subsections to group related parameters. This improves the readability of the auto-generated help page.

```cpp
parser.add_subsection("Input/Output Options");
// Subsequent options will be grouped under this header
```

### Positional Arguments
For arguments that do not use a flag (like a list of input files), use positional options.

```cpp
std::vector<std::string> input_files;
parser.add_positional_option(input_files, sharg::config{.description = "One or more input files."});
```

## CLI Usage and Built-in Features

Applications built with Sharg automatically support several standard flags without additional coding:

- **Help**: `-h` or `--help` for basic help; `-hh` or `--advanced-help` for all options.
- **Metadata**: `--version` and `--copyright` display tool information.
- **Documentation Export**: `--export-help <format>` allows users to generate documentation. Supported formats include `html` and `man`.
- **Version Check**: `--version-check true/false` toggles checking for the newest app version.

## Expert Tips
- **C++ Requirement**: Ensure your environment uses a modern compiler (GCC 13+ or Clang 19+) as Sharg relies heavily on C++20 features.
- **Automatic Validation**: Sharg automatically validates types. If a user provides a string for an integer option, the parser will catch the error, print a message, and exit gracefully.
- **Header-Only**: No linking is required. Simply include the `sharg` headers in your project and ensure the include path is set correctly in your build system (e.g., CMake).

## Reference documentation
- [Sharg Parser GitHub](./references/github_com_seqan_sharg-parser.md)
- [Bioconda Sharg Overview](./references/anaconda_org_channels_bioconda_packages_sharg_overview.md)