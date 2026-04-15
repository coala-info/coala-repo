---
name: perl-extutils-constant
description: This tool automates the generation of C and XS code to make C header constants accessible within Perl modules. Use when user asks to bridge C macros to Perl space, generate constant-handling boilerplate, or integrate constant generators into a Perl distribution's build process.
homepage: http://metacpan.org/pod/ExtUtils::Constant
metadata:
  docker_image: "quay.io/biocontainers/perl-extutils-constant:0.25--pl526h14c3975_0"
---

# perl-extutils-constant

## Overview
`ExtUtils::Constant` is a standard Perl toolset used to bridge the gap between C header file constants and Perl space. It automates the creation of the "boilerplate" C and XS code required to make C macros (like `FOO_FLAGS`) accessible as Perl constants (like `Module::FOO_FLAGS`). This skill provides the procedural knowledge to integrate these constant generators into a Perl distribution's build process.

## Core Workflow
The most common implementation pattern involves calling `WriteConstants` within `Makefile.PL`. This ensures that the constant-handling code is regenerated whenever the module is configured.

### 1. Configure Makefile.PL
Add the following logic to your `Makefile.PL` to generate the necessary include files:

```perl
use ExtUtils::Constant qw(WriteConstants);

my @constants = qw(
    CONFIG_MAX_PATH
    DEFAULT_TIMEOUT
    ENABLE_FEATURE_X
);

WriteConstants(
    NAME         => 'My::Module',
    NAMES        => \@constants,
    DEFAULT_TYPE => 'IV',        # Integer Value
    C_FILE       => 'const-c.inc',
    XS_FILE      => 'const-xs.inc',
);
```

### 2. Update the XS File (.xs)
In your module's main XS file (e.g., `Module.xs`), include the generated snippets in their respective sections:

```c
/* In the C section (before the MODULE line) */
#include "const-c.inc"

MODULE = My::Module    PACKAGE = My::Module

/* In the XS section (after the PACKAGE line) */
INCLUDE: const-xs.inc
```

## Supported Data Types
When defining constants in the `NAMES` array, you can specify types if they are not the `DEFAULT_TYPE` (IV):

| Type | Description |
| :--- | :--- |
| **IV** | Signed integer (default) |
| **UV** | Unsigned integer |
| **NV** | Floating point (double) |
| **PV** | NUL-terminated string |
| **PVN** | Fixed length string [pointer, length] |
| **SV** | Scalar Value (mortal) |
| **UNDEF** | Perl `undef` |

**Example of mixed types:**
```perl
NAMES => [
    'MAX_RETRY',                                    # Defaults to IV
    { name => 'VERSION_STR', type => 'PV' },        # String
    { name => 'PI',          type => 'NV' },        # Double
    { name => 'IS_DEBUG',    type => 'YES' },       # Truth value
],
```

## Best Practices
- **File Naming**: Stick to the default `const-c.inc` and `const-xs.inc`. The hyphen in the filename prevents Perl from mistaking these files for package directories.
- **Maintenance**: Do not manually edit the `.inc` files. Always update the `NAMES` list in `Makefile.PL` and re-run `perl Makefile.PL`.
- **AUTOLOAD Integration**: `ExtUtils::Constant` generates a `constant` subroutine. Ensure your Perl module's `AUTOLOAD` function is set up to call this routine when a constant is accessed.
- **Breakout Optimization**: For modules with a very large number of constants (e.g., >100), use the `BREAKOUT_AT` attribute in `WriteConstants` to split the lookup logic into multiple C functions, which can improve compilation speed.

## Reference documentation
- [ExtUtils::Constant Documentation](./references/metacpan_org_pod_ExtUtils__Constant.md)