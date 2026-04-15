---
name: perl-ffi-checklib
description: This Perl utility locates dynamic libraries across different operating systems for use with Foreign Function Interface calls. Use when user asks to find the path of a dynamic library, verify the presence of specific symbols, or validate library dependencies during a Perl module build process.
homepage: https://metacpan.org/pod/FFI::CheckLib
metadata:
  docker_image: "quay.io/biocontainers/perl-ffi-checklib:0.31--pl5321hdfd78af_0"
---

# perl-ffi-checklib

## Overview

`FFI::CheckLib` is a Perl-based utility designed to locate dynamic libraries (such as `.so`, `.dll`, or `.dylib` files) across different operating systems. Unlike `Devel::CheckLib`, which checks for development headers, this tool finds the actual compiled libraries needed for FFI calls. It is a core dependency for projects using `FFI::Platypus` to ensure that the environment is correctly configured before attempting to load external functions.

## Core Functions and Usage

### Library Discovery
Use `find_lib` to locate the full path of a library. This is often passed directly to an FFI loader.

```perl
use FFI::CheckLib;

# Find a single library
my $path = find_lib( lib => 'jpeg' );

# Find multiple libraries
my @paths = find_lib( lib => [ 'ssl', 'crypto' ] );
```

### Build-Time Validation
In `Makefile.PL` or `Build.PL`, use `check_lib_or_exit` to prevent installation on systems missing required dependencies.

```perl
use FFI::CheckLib;

check_lib_or_exit( 
    lib    => 'archive', 
    symbol => [ 'archive_read_new', 'archive_write_free' ] 
);
```

### Advanced Probing
*   **Symbol Checking**: Ensure the library contains specific functions using `symbol`.
*   **Custom Verification**: Use the `verify` callback to perform version checks or complex validation using `FFI::Platypus`.
*   **Recursive Search**: Set `recursive => 1` when searching custom `libpath` directories.
*   **Linker Scripts**: On Linux distributions like Red Hat that use linker scripts instead of symlinks for some `.so` files, set `try_linker_script => 1`.

```perl
my $lib = find_lib(
    lib    => 'foo',
    verify => sub {
        my($name, $libpath) = @_;
        # Return true if library meets criteria
        return $libpath =~ /lib64/;
    }
);
```

## Best Practices

1.  **Library Naming**: Always provide the base name of the library (e.g., `jpeg` instead of `libjpeg.so`). `FFI::CheckLib` automatically handles platform-specific prefixes and extensions.
2.  **Alien Integration**: If your module has a corresponding `Alien::` module, use the `alien` parameter to provide a fallback if the system library is missing.
    ```perl
    find_lib( lib => 'lzma', alien => 'Alien::LibLZMA' );
    ```
3.  **System Paths**: By default, the tool searches standard system paths. To restrict the search to only specific directories, pass an empty array to `systempath`.
4.  **Symbol Verification**: Always check for at least one core symbol if you are targeting a library that might have multiple incompatible versions installed.

## Reference documentation
- [FFI::CheckLib - MetaCPAN](./references/metacpan_org_pod_FFI__CheckLib.md)