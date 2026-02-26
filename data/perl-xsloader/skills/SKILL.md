---
name: perl-xsloader
description: "XSLoader pulls compiled C or C++ code into a Perl namespace to enable the use of XS extensions. Use when user asks to load shared libraries into Perl modules, implement bootstrap calls for XS-based distributions, or use a lightweight alternative to DynaLoader."
homepage: https://metacpan.org/module/XSLoader
---


# perl-xsloader

## Overview
XSLoader is the standard Perl core module used to pull compiled C or C++ code (XS) into a Perl namespace. Unlike its predecessor DynaLoader, XSLoader is designed to be lightweight by only loading the necessary shared object (.so or .bundle) files without inheriting the overhead of the full DynaLoader class hierarchy. This skill assists in implementing the `bootstrap` calls required in the `.pm` file of an XS-based distribution.

## Implementation Patterns

### Standard Boilerplate
To use XSLoader, place the following at the top of your Perl module. Ensure the version passed to `load` matches the `$VERSION` variable of your module to prevent binary incompatibility.

```perl
package Your::Module;

use strict;
use warnings;
use XSLoader;

our $VERSION = '0.01';

XSLoader::load(__PACKAGE__, $VERSION);

1;
```

### Best Practices
- **Placement**: Always call `XSLoader::load` from the main body of your library, not inside a `sub BEGIN` block, to ensure the package name is correctly identified.
- **Namespace Consistency**: The first argument to `load` should almost always be `__PACKAGE__`. This ensures that the compiled C functions are installed into the correct Perl namespace.
- **Version Checking**: Always provide the second argument (`$VERSION`). This acts as a safety check to ensure the compiled `.so` file matches the Perl code version.
- **Legacy Fallback**: If you must support extremely old versions of Perl (pre-5.6) where XSLoader might not be in core, use a `require` inside an `eval` block, though this is rarely necessary in modern Bioconda or MetaCPAN environments.

### Troubleshooting
- **File Not Found**: If loading fails, verify that the `.so` or `.dll` file is located in the `auto/` directory of your distribution's architecture-specific library path (`@INC`).
- **Undefined Symbols**: This usually indicates a compilation error or a missing external library dependency during the linking phase of `make`, rather than a fault in XSLoader itself.

## Reference documentation
- [XSLoader - MetaCPAN](./references/metacpan_org_module_XSLoader.md)
- [Bioconda perl-xsloader Overview](./references/anaconda_org_channels_bioconda_packages_perl-xsloader_overview.md)