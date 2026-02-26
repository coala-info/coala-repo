---
name: tclap
description: TCLAP is a header-only C++ library used for parsing command-line arguments in a type-safe and templatized manner. Use when user asks to parse command-line flags, define type-safe arguments, generate automatic help messages, or handle positional and mutually exclusive parameters in C++ applications.
homepage: https://github.com/mirror/tclap
---


# tclap

## Overview

TCLAP is a header-only C++ library designed to simplify the process of parsing command-line arguments. Unlike many other parsers, TCLAP is entirely templatized, allowing it to handle various data types (int, string, float, or custom types) in a type-independent manner. It is particularly useful for developers who want a robust, type-safe alternative to `getopt` that integrates cleanly with C++ idioms and provides automatic help message generation.

## Implementation Best Practices

### Core Workflow
1. **Initialize the CmdLine object**: This acts as the manager for all arguments.
2. **Define Arguments**: Create instances of `ValueArg`, `SwitchArg`, `MultiArg`, or `UnlabeledValueArg`.
3. **Add to CmdLine**: Use the `add()` method or pass arguments directly into the `CmdLine` constructor.
4. **Parse**: Call `cmd.parse(argc, argv)`.
5. **Access Values**: Use the `getValue()` method on your argument objects.

### Argument Types
- **SwitchArg**: For boolean flags (e.g., `-f` or `--force`).
- **ValueArg<T>**: For arguments requiring a single value (e.g., `-n 10`).
- **MultiArg<T>**: For arguments that can appear multiple times, storing values in a `std::vector<T>`.
- **UnlabeledValueArg<T>**: For positional arguments that do not have a flag.

### Expert Tips
- **Type Safety**: Since TCLAP is templatized, it uses `operator>>` to parse values. Ensure any custom types used in `ValueArg<T>` have this operator defined.
- **Constraint Handling**: Use `ValueConstraint<T>` to restrict input to a specific set of valid values. This is checked during the parsing phase, preventing the application from receiving invalid data.
- **Exception Management**: Wrap the `parse` call in a `try-catch` block. TCLAP throws `ArgException` for parsing errors and `ExitException` when the program should terminate (e.g., after displaying `--help` or `--version`).
- **XOR Groups**: Use `cmd.xorAdd()` to define mutually exclusive arguments where exactly one of a set must be provided.
- **Customizing Help**: You can override the default `StdOutput` class if you need to customize the format of the auto-generated help and version messages.

## Common CLI Patterns

### Basic Setup
```cpp
#include <tclap/CmdLine.h>

int main(int argc, char** argv) {
    try {
        TCLAP::CmdLine cmd("Command description message", ' ', "0.9");

        TCLAP::ValueArg<std::string> nameArg("n", "name", "Name to print", true, "homer", "string");
        cmd.add(nameArg);

        TCLAP::SwitchArg reverseSwitch("r", "reverse", "Print name backwards", false);
        cmd.add(reverseSwitch);

        cmd.parse(argc, argv);

        std::string name = nameArg.getValue();
        bool reverse = reverseSwitch.getValue();
        // ... logic ...

    } catch (TCLAP::ArgException &e) {
        std::cerr << "error: " << e.error() << " for arg " << e.argId() << std::endl;
    }
}
```

### Handling Multiple Values
When using `MultiArg<int>`, the user can provide `-i 1 -i 10 -i 100`. Access these via `std::vector<int> vals = multiArg.getValue();`.

## Reference documentation
- [TCLAP Main Repository](./references/github_com_mirror_tclap.md)
- [TCLAP Commit History (API Evolution)](./references/github_com_mirror_tclap_commits_master.md)