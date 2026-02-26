---
name: perl-sub-identify
description: This tool retrieves the original name, package, and source location of Perl code references. Use when user asks to identify the origin of a subroutine, find the file and line number where a function is defined, or check if a subroutine is a constant.
homepage: http://metacpan.org/pod/Sub::Identify
---


# perl-sub-identify

## Overview
The `perl-sub-identify` skill provides the ability to look "inside" Perl code references to determine their identity. While Perl's built-in tools often return generic information for anonymous subs, this tool allows you to retrieve the original name, the stash (package) it belongs to, and the exact file and line number where the subroutine was defined. This is particularly valuable when working with dynamic code generation or large legacy codebases where function origins are non-obvious.

## Installation
In a bioconda-enabled environment, install the package using:
```bash
conda install bioconda::perl-sub-identify
```

## Core Functions
The module is typically used within Perl scripts or one-liners. Import all functions using the `:all` tag:

```perl
use Sub::Identify ':all';
```

| Function | Description |
|----------|-------------|
| `sub_name($ref)` | Returns the name of the sub (returns `__ANON__` for anonymous subs). |
| `stash_name($ref)` | Returns the package name where the sub was defined. |
| `sub_fullname($ref)` | Returns the fully qualified name (`Package::Subname`). |
| `get_code_info($ref)` | Returns a list: `($package, $name)`. Faster than calling both separately. |
| `get_code_location($ref)`| Returns a list: `($file, $line)`. |
| `is_sub_constant($ref)` | Returns a boolean indicating if the sub is a constant. |

## CLI Usage Patterns
You can use `Sub::Identify` in Perl one-liners to quickly inspect modules or references from the command line.

### Identifying a Subroutine's Origin
To find where a specific function in a loaded module is defined:
```bash
perl -MSub::Identify=:all -MModule::Name -e 'print join(":", get_code_location(\&Module::Name::function_name)), "\n"'
```

### Checking for Constant Subroutines
To verify if a symbol is a constant (which Perl often implements as a sub):
```bash
perl -MSub::Identify=:all -MModule::Name -e 'print is_sub_constant(\&Module::Name::CONST_NAME) ? "Constant" : "Not Constant"'
```

## Expert Tips
*   **Subroutine Aliasing**: If a subroutine has been aliased (e.g., `*new_name = \&old_name`), `Sub::Identify` functions will return the **original** name, not the alias.
*   **Pure-Perl Fallback**: If the high-speed XS implementation cannot be loaded, the module falls back to a Pure-Perl version using the `B` module. You can force this mode for debugging by setting the environment variable `PERL_SUB_IDENTIFY_PP=1`.
*   **Migration Path**: For projects using Perl 5.22.0 or later, consider migrating to `Sub::Util` (part of the core `Scalar::List::Utils` distribution), as it provides similar functionality and is maintained as part of the Perl core.

## Reference documentation
- [Sub::Identify - Retrieve names of code references](./references/metacpan_org_pod_Sub__Identify.md)
- [perl-sub-identify - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-sub-identify_overview.md)