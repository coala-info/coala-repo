---
name: perl-symbol-util
description: This Perl module provides a functional interface for safely manipulating the Perl symbol table and managing package stashes. Use when user asks to fetch stashes, delete specific subroutines or typeglob slots, and perform dynamic symbol exporting or namespace cleanup between packages.
homepage: https://github.com/dex4er/perl-Symbol-Util
---


# perl-symbol-util

## Overview
Symbol::Util is a Perl module designed to simplify the manipulation of the Perl symbol table. In Perl, symbols are organized into "stashes" (symbol table hashes), and each entry is a "typeglob" containing multiple slots (SCALAR, CODE, HASH, etc.). This skill provides a functional interface to interact with these internals safely. Use this skill to fetch stashes, delete specific parts of a symbol (like a subroutine) while leaving others intact, and perform dynamic symbol exporting or unexporting between packages.

## Usage Patterns

### Safe Symbol Access
Avoid using `no strict 'refs'` by using the functional interface to fetch stashes and globs.

```perl
use Symbol::Util qw(stash fetch_glob);

# Get the symbol table for a package
my $package_stash = stash("My::Package");

# Fetch a specific code reference from a dynamic name
my $coderef = fetch_glob("My::Package::dynamic_sub", "CODE");
```

### API Cleanup and Method Hiding
Use `delete_sub` to remove a subroutine from a package's API. This is particularly useful for removing imported constants or utility functions so they cannot be called as object methods by consumers of your class.

```perl
use Symbol::Util qw(delete_sub);
use constant INTERNAL_PI => 3.14159;

# Remove the constant from the package API so it's not a method
delete_sub "INTERNAL_PI";
```

### Granular Symbol Deletion
Unlike simply undefining a variable, `delete_glob` allows you to target specific slots within a typeglob.

```perl
use Symbol::Util qw(delete_glob);

# Delete only the CODE slot (the subroutine) but keep $User::data (SCALAR)
delete_glob("User::data", "CODE");
```

### Dynamic Exporting
Manage symbols between packages at runtime without inheriting from `Exporter`.

```perl
use Symbol::Util qw(export_package unexport_package);

# Import 'Dump' from YAML into the current package
export_package(__PACKAGE__, "YAML", "Dump");

# Later, remove the imported symbol to clean up the namespace
unexport_package(__PACKAGE__, "YAML");
```

## Expert Tips
- **Namespace Cleaning**: When writing a library, use `unexport_package` in a `BEGIN` block or at the end of the file to ensure that utility functions used during development don't leak into the end-user's namespace.
- **Slot Specificity**: When using `fetch_glob` or `delete_glob`, valid slots are `SCALAR`, `ARRAY`, `HASH`, `CODE`, `IO`, and `FORMAT`.
- **Strict Compliance**: This module is specifically designed to work under `use strict`, making it a safer alternative to manual typeglob manipulation (e.g., `*{"main::$var"}`).

## Reference documentation
- [Symbol::Util README](./references/github_com_dex4er_perl-Symbol-Util.md)