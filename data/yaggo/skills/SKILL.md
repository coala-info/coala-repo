---
name: yaggo
description: Yaggo is a C++ code generation tool that automates the creation of command-line argument parsers. Use when user asks to define command-line arguments, generate a C++ parser header, or automate command-line parsing for a C++ program.
homepage: https://github.com/gmarcais/yaggo
---


# yaggo

## Overview
Yaggo (Yet Another GenGetOpt) is a C++ code generation tool that automates the creation of command-line argument parsers. By defining program switches and arguments in a high-level configuration file, developers can generate a single, self-contained C++ header file that handles all parsing logic, error reporting, and help message generation using `getopt_long`.

## Configuration Syntax
The `.yaggo` configuration file uses a domain-specific language to define the parser's behavior.

### Metadata
- `purpose`: A short string describing the program's goal.
- `description`: A longer string providing detailed information about the program.

### Options (Switches)
Options are defined using the `option` keyword followed by short and long names.
- **Flags**: Use the `off` keyword to define a boolean flag that defaults to false.
- **Typed Options**: Specify types like `int`, `float`, `string`, or `c_string`.
- **Defaults**: Use the `default` keyword to provide a fallback value.

```cpp
option ("f", "flag") {
  description "A simple boolean flag"
  off
}

option ("i", "int") {
  description "An integer parameter"
  int
  default 10
}
```

### Positional Arguments
Use the `arg` keyword to define required or optional positional arguments.
```cpp
arg ("output") {
  description "Path to the output file"
  c_string
}
```

## Workflow and Integration

### 1. Generate the Header
Run the `yaggo` command on your configuration file to produce a C++ header (usually `.hpp`).
```bash
yaggo parser.yaggo
```

### 2. Include and Instantiate
Include the generated header in your C++ source. The parser logic is encapsulated in a class named after your configuration file (or the default `parser` class).

```cpp
#include "parser.hpp"

int main(int argc, char* argv[]) {
    // The constructor performs the parsing and handles errors/help automatically
    parser args(argc, argv);

    // Access values using the naming convention: <name>_arg or <name>_flag
    if (args.flag_flag) {
        std::cout << "Integer value: " << args.int_arg << std::endl;
    }
    return 0;
}
```

### 3. Compilation
Since the generated header is self-contained and relies on standard libraries, no additional linking is required beyond standard C++ compilation.
```bash
g++ -o my_program main.cpp
```

## Expert Tips
- **Automatic Help**: Yaggo automatically generates `-h`, `--help`, and `--usage` switches. You do not need to define these manually.
- **Type Safety**: Prefer `c_string` for file paths and `string` for general text to ensure compatibility with standard C++ string handling.
- **Validation**: Yaggo handles basic type validation (e.g., ensuring an `int` option receives a numeric value) and will exit the program with a usage message if parsing fails.
- **Documentation**: Use `yaggo --man` after installation to view the full manual and advanced configuration keywords.

## Reference documentation
- [yaggo GitHub Repository](./references/github_com_gmarcais_yaggo.md)
- [yaggo Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_yaggo_overview.md)