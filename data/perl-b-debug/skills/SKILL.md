---
name: perl-b-debug
description: The perl-b-debug tool walks the Perl syntax tree to display the internal operations and structure of compiled code. Use when user asks to dump the operation tree, inspect how the Perl compiler interprets specific syntax, or debug the compilation phase of a script.
homepage: http://metacpan.org/pod/B::Debug
---


# perl-b-debug

## Overview
The `perl-b-debug` tool provides a window into how the Perl interpreter compiles and structures code before execution. By invoking the `B::Debug` module, you can walk the syntax tree of any Perl script to see exactly which operations are being performed, their sequence, and their internal attributes. This is particularly useful when standard debugging techniques fail to explain unexpected behavior or when you need to verify how the Perl compiler is interpreting specific syntax constructs.

## Usage Instructions

### Basic Invocation
To dump the operation tree of a Perl script, use the `-MO=Debug` flag when running the perl interpreter:

```bash
perl -MO=Debug script.pl
```

### Common Patterns
- **One-liners**: Inspect how Perl handles a specific expression without creating a file:
  ```bash
  perl -MO=Debug -e 'print "hello" . $world'
  ```
- **Filtering Output**: Since the output can be verbose, pipe to `less` or `grep` to find specific operation types (e.g., `gvsv`, `entersub`):
  ```bash
  perl -MO=Debug -e 'your_code' | grep "OP"
  ```

### Expert Tips
- **Compile-time Only**: Note that `B::Debug` runs during the compilation phase. It shows the structure of the code, not the runtime state of variables.
- **Identifying Bottlenecks**: Look for deeply nested `nextstate` and `list` ops which might indicate overly complex logic that could be refactored for better compilation efficiency.
- **Module Debugging**: You can debug how a specific module is loaded by including it in a one-liner:
  ```bash
  perl -MO=Debug -MModule::Name -e 1
  ```

## Reference documentation
- [B::Debug Documentation](./references/metacpan_org_pod_B__Debug.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-b-debug_overview.md)