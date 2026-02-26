---
name: perl-config-autoconf
description: This Perl module replicates GNU Autoconf functionality to probe host system capabilities like C headers, libraries, and compiler characteristics. Use when user asks to check for system headers, verify library functions, search for executables, or determine data type sizes in Perl configuration scripts.
homepage: https://metacpan.org/release/Config-AutoConf
---


# perl-config-autoconf

## Overview
This skill facilitates the use of `Config::AutoConf`, a Perl module that replicates the functionality of GNU Autoconf. It allows developers to write configuration scripts (`Makefile.PL` or `Build.PL`) that probe the host system for capabilities, such as the presence of specific C headers, libraries, or compiler characteristics. This is essential for creating portable Perl extensions that interface with C code or system-level APIs.

## Implementation Patterns

### Basic Configuration Setup
To use `Config::AutoConf` in a build script, initialize the object and perform checks before generating the Makefile:

```perl
use Config::AutoConf;

my $ac = Config::AutoConf->new();

# Check for a C header
$ac->check_header("ncurses.h") or die "ncurses.h not found";

# Check for a library function
if ($ac->check_func("printf")) {
    # Logic for when function exists
}

# Check for a library
$ac->check_lib("m", "sqrt") or die "Math library not found";
```

### Common Probing Methods
*   `check_prog($prog)`: Search for an executable in the PATH.
*   `check_cc()`: Verify that a C compiler is available and functional.
*   `check_sizeof_type($type)`: Determine the byte size of a specific data type.
*   `check_decl($symbol)`: Check if a symbol is declared in a header.

### Best Practices
*   **Cache Results**: `Config::AutoConf` automatically handles caching of results to speed up subsequent runs. Do not manually override the cache unless testing environment changes.
*   **Conditional Compilation**: Use the results of `check_header` or `check_lib` to populate `INC` and `LIBS` parameters in `ExtUtils::MakeMaker`.
*   **Pure Perl Fallbacks**: When a system check fails, use the logic to provide a pure-Perl alternative or a descriptive error message to the user.

## Reference documentation
- [Config-AutoConf on MetaCPAN](./references/metacpan_org_release_Config-AutoConf.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-config-autoconf_overview.md)