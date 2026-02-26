---
name: perl-devel-checklib
description: This tool verifies the presence of specific C libraries, header files, and symbols on a system during the Perl module configuration process. Use when user asks to check for library dependencies, verify header file availability, or ensure specific symbols exist before compiling Perl modules.
homepage: http://metacpan.org/pod/Devel-CheckLib
---


# perl-devel-checklib

## Overview
This skill provides guidance on using `Devel::CheckLib` to verify that specific C libraries, header files, and symbols are available on the host system. It is primarily used during the "configure" stage of Perl module installation to provide meaningful error messages to users when dependencies are missing, rather than allowing the compiler to fail later with cryptic errors.

## Usage Patterns

### Basic Library Check
To check if a library (e.g., `libjpeg`) is available for linking:
```perl
use Devel::CheckLib;

check_lib_or_exit(
    lib => 'jpeg',
    header => 'jpeglib.h',
);
```

### Checking for Specific Symbols
To ensure a library is not only present but also contains a specific function:
```perl
check_lib_or_exit(
    lib     => 'crypto',
    symbol  => 'EVP_encryptinit',
);
```

### Multiple Dependencies
You can pass arrays to check for multiple requirements simultaneously:
```perl
check_lib(
    lib    => [qw( ssl crypto )],
    header => [qw( openssl/ssl.h openssl/err.h )],
);
```

### Command Line Testing
You can use the `use-devel-checklib` script (if provided by the distribution) or a one-liner to test the environment manually:
```bash
perl -MDevel::CheckLib -e 'check_lib_or_exit(lib => "z")'
```

## Best Practices
- **Use `check_lib_or_exit`**: In `Makefile.PL`, use the `_or_exit` variant. This follows the CPAN convention of exiting with status 0 when dependencies are missing, which prevents automated testers (CPAN Testers) from reporting a "Fail" when it is simply a missing system library.
- **Specify Headers**: Always check for the corresponding header file. A library might be installed (runtime), but the development headers (e.g., `-dev` or `-devel` packages) might be missing.
- **Custom Paths**: If libraries are in non-standard locations, use `libpath` and `incpath`:
  ```perl
  check_lib(
      lib     => 'foo',
      libpath => '/opt/local/lib',
      incpath => '/opt/local/include',
  );
  ```

## Reference documentation
- [Devel::CheckLib Documentation](./references/metacpan_org_pod_Devel-CheckLib.md)