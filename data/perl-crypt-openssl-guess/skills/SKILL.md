---
name: perl-crypt-openssl-guess
description: The `perl-crypt-openssl-guess` skill facilitates the automated discovery of OpenSSL installation paths within Perl development workflows.
homepage: https://github.com/akiym/Crypt-OpenSSL-Guess
---

# perl-crypt-openssl-guess

## Overview

The `perl-crypt-openssl-guess` skill facilitates the automated discovery of OpenSSL installation paths within Perl development workflows. It is primarily used within `Makefile.PL` scripts to ensure that C-based Perl extensions (like the `Crypt::OpenSSL::*` family) can correctly locate headers and libraries during the compilation phase. This tool eliminates the need for hardcoded paths and provides a standardized way to handle environment-specific configurations, such as those found on macOS where OpenSSL is often installed in non-standard locations via Homebrew.

## Integration Patterns

### Using in Makefile.PL

The most common use case is integrating the module into a module's build script to dynamically set compiler and linker flags.

```perl
use ExtUtils::MakeMaker;
use Crypt::OpenSSL::Guess;

WriteMakefile(
    NAME => 'Your::Module::Name',
    # Automatically guess and append -lssl -lcrypto to the library path
    LIBS => [openssl_lib_paths() . ' -lssl -lcrypto'],
    # Automatically guess the include path
    INC  => openssl_inc_paths(),
);
```

### Overriding Discovery

If the automatic guessing fails or a specific OpenSSL version is required, use the `OPENSSL_PREFIX` environment variable. The tool prioritizes this variable over its internal heuristics.

```bash
export OPENSSL_PREFIX=/opt/custom/openssl
perl Makefile.PL
```

## Function Reference

- **`openssl_inc_paths()`**: Returns the include path string formatted for the compiler (e.g., `-I/usr/local/opt/openssl/include`). Returns an empty string if OpenSSL is not found.
- **`openssl_lib_paths()`**: Returns the library path string formatted for the linker (e.g., `-L/usr/local/opt/openssl/lib`).
- **`find_openssl_prefix([$dir])`**: Returns the base directory where OpenSSL is installed.
- **`find_openssl_exec($prefix)`**: Returns the path to the `openssl` binary.
- **`openssl_version()`**: Returns a list containing the major version, minor version, and letter (e.g., `("1.0", "2", "n")`).

## Best Practices

- **Linker Order**: When using `openssl_lib_paths()`, ensure the returned path (the `-L` flag) precedes the library flags (`-lssl -lcrypto`) to ensure the linker searches the guessed directory first.
- **macOS Compatibility**: This module is the preferred way to handle macOS builds where system OpenSSL headers are often deprecated or missing, as it correctly identifies Homebrew's `keg-only` OpenSSL installations.
- **Dependency Management**: If you are authoring a module, add `Crypt::OpenSSL::Guess` to your `configure_requires` in `META.json` or `Makefile.PL` to ensure it is available during the build process.

## Reference documentation
- [Crypt::OpenSSL::Guess GitHub Repository](./references/github_com_akiym_Crypt-OpenSSL-Guess.md)
- [Bioconda perl-crypt-openssl-guess Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-crypt-openssl-guess_overview.md)