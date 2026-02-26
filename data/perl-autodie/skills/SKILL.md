---
name: perl-autodie
description: The perl-autodie pragma replaces standard Perl built-in functions with versions that automatically throw exceptions upon failure. Use when user asks to enable automatic error handling for Perl scripts, replace manual die statements with lexical exceptions, or manage error checking for specific I/O and system categories.
homepage: http://metacpan.org/pod/autodie
---


# perl-autodie

## Overview
The `autodie` pragma is a powerful tool for Perl developers that replaces standard built-in functions with versions that automatically throw exceptions on failure. Instead of manually appending `or die $!` to every function call, `autodie` provides a cleaner, less error-prone way to ensure that failures are never ignored. It is lexically scoped, meaning its effects are confined to the block, file, or eval in which it is loaded.

## Implementation Patterns

### Basic Usage
To enable default error checking (covering most file and I/O operations) for the current scope:
```perl
use autodie;

open(my $fh, '<', $filename); # Automatically dies on failure
```

### Comprehensive Coverage
To include `system` and `exec` calls (requires `IPC::System::Simple` to be installed):
```perl
use autodie qw(:all);

system("some_command"); # Dies if command fails or returns non-zero
```

### Specific Function Control
You can limit `autodie` to specific functions or categories, or disable it within a nested block:
```perl
use autodie qw(open close :filesys);

{
    no autodie qw(open); 
    open(my $fh, '<', $optional_file); # Failure here will not trigger an exception
}
```

## Exception Handling
Exceptions thrown by `autodie` are objects of the `autodie::exception` class. Use `eval` blocks and the `isa` method to handle them:

```perl
eval {
    use autodie;
    open(my $fh, '<', $file);
};
if ($@ && $@->isa('autodie::exception')) {
    if ($@->matches('open')) {
        warn "Failed to open file: " . $@->message;
    }
}
```

## Categories
Use categories to enable groups of functions:
- `:io` - read, seek, sysread, sysseek, syswrite
- `:file` - binmode, close, chmod, chown, fcntl, flock, ioctl, open, sysopen, truncate
- `:filesys` - chdir, closedir, opendir, link, mkdir, readlink, rename, rmdir, symlink, unlink
- `:ipc` - kill, pipe
- `:socket` - accept, bind, connect, listen, recv, send, socket, etc.
- `:system` - system, exec

## Expert Tips and Constraints
- **Print is excluded**: `autodie` does NOT check `print` statements. You must still check these manually if success is critical.
- **Flock behavior**: `autodie` ignores `EWOULDBLOCK` errors for `flock`, as these are often expected in non-blocking logic.
- **Lexical Scope**: Always remember that `use autodie` only affects the current block. If you call a subroutine defined outside that block, it will use its own error-handling logic.
- **Version Surety**: Use `use autodie qw(:1.994);` to lock the `:default` list to a specific version's behavior, preventing breaks during module upgrades.

## Reference documentation
- [autodie - Replace functions with ones that succeed or die with lexical scope](./references/metacpan_org_pod_autodie.md)
- [perl-autodie - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-autodie_overview.md)