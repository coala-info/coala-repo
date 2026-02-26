---
name: perl-findbin-real
description: The perl-findbin-real module allows a Perl script to discover its own filesystem location at runtime, providing a reliable alternative to the standard FindBin module for persistent environments. Use when user asks to locate the directory of the original Perl script, resolve the physical path of a script symlink, or dynamically add library paths relative to the executable's location.
homepage: https://metacpan.org/pod/FindBin::Real
---


# perl-findbin-real

## Overview
The `FindBin::Real` module provides a reliable way for a Perl script to discover its own location on the filesystem. Unlike the standard `FindBin` module, which uses a `BEGIN` block that can cause issues in persistent environments (like mod_perl or FastCGI), `FindBin::Real` uses functions that are evaluated at runtime. This ensures that multiple scripts running under the same interpreter instance correctly identify their respective paths. It is primarily used to dynamically add library directories (`lib`) to the `@INC` path relative to the executable's location (`bin`).

## Usage Patterns

### Basic Directory Discovery
To add a library directory located at `../lib` relative to the script:
```perl
use FindBin::Real;
use lib FindBin::Real::Bin() . '/../lib';
```

### Using Exported Symbols
For cleaner syntax, export the `Bin` function:
```perl
use FindBin::Real qw(Bin);
use lib Bin() . '/../lib';
```

### Handling Deep Directory Structures
If your script is nested deep within a sub-directory (e.g., `bin/tools/subdir/script.pl`) and you need to reach a top-level `lib` directory, use `BinDepth(n)`:
```perl
use FindBin::Real qw(BinDepth);
# Moves up 3 levels from the script's location
use lib BinDepth(3) . '/lib';
```

### Resolving Symlinks
If the script is a symbolic link and you need the physical path of the target:
```perl
use FindBin::Real qw(RealBin);
use lib RealBin() . '/../lib';
```

## Exportable Functions
- `Bin()` / `Dir()`: Returns the path to the directory containing the invoked script.
- `Script()`: Returns the basename of the invoked script.
- `RealBin()` / `RealDir()`: Returns the `Bin()` path with all symbolic links resolved.
- `RealScript()`: Returns the `Script()` name with all symbolic links resolved.
- `BinDepth(n)`: Returns the path to the n-th parent directory of the script.

## Best Practices and Tips
- **Persistent Environments**: Always prefer `FindBin::Real` over `FindBin` when working with `mod_perl` or other persistent Perl interpreters to avoid path "bleeding" between different scripts.
- **Security/Permissions**: If invoking a script via `perl filename` where the file lacks executable bits but a file with the same name exists in `$ENV{PATH}`, the module may misidentify the path. To prevent this, invoke scripts using relative paths: `perl ./filename`.
- **Standardization**: Use `Bin()` for most application logic; use `RealBin()` only when your application logic specifically depends on the physical location of files rather than the logical deployment path.

## Reference documentation
- [FindBin::Real - Locate directory of original perl script](./references/metacpan_org_pod_FindBin__Real.md)