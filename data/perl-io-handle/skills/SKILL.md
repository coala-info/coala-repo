---
name: perl-io-handle
description: The `perl-io-handle` skill provides an object-oriented interface for Perl I/O handles, serving as the base class for more specialized modules like `IO::File`.
homepage: http://metacpan.org/pod/IO::Handle
---

# perl-io-handle

## Overview

The `perl-io-handle` skill provides an object-oriented interface for Perl I/O handles, serving as the base class for more specialized modules like `IO::File`. It allows developers to treat filehandles as objects, providing a cleaner syntax for standard operations and advanced control over stream behavior that is often cumbersome with built-in Perl glob handles. Use this skill to manage input/output streams with greater precision, particularly when dealing with complex buffering requirements or file descriptor manipulation.

## Usage and Best Practices

### Core Object Management
- **Initialize handles**: Use `IO::Handle->new()` to create a new object, or `IO::Handle->new_from_fd($fd, $mode)` to wrap an existing file descriptor.
- **Verify state**: Always check `$io->opened` to confirm a handle is valid before attempting I/O operations.
- **Clean up**: Explicitly call `$io->close` to ensure buffers are flushed and resources are released, though objects will automatically close when they go out of scope.

### Input Operations
- **Prefer `getline`**: Use `$io->getline` instead of the `<$io>` operator for better readability. It returns a single line even in list context, preventing accidental slurp behavior.
- **Bulk reading**: Use `$io->getlines` to read all remaining lines. Note that this method will `croak()` if called in a scalar context to prevent logic errors.
- **Character pushback**: Use `$io->ungetc($ord)` to push a character back onto the input stream, which is useful for building simple parsers.

### Output and Buffering Control
- **Enable Autoflush**: Use `$io->autoflush(1)` to ensure data is written immediately to the output. This is the object-oriented equivalent of setting `$| = 1` and is essential for interactive CLI tools or logging.
- **Manual Flushing**: Call `$io->flush` to force any buffered data at the PerlIO level to be written to the underlying file descriptor.
- **Physical Sync**: Use `$io->sync` to synchronize the file's in-memory state with the physical storage medium. Note that `sync` operates on the file descriptor and does not flush Perl-level buffers; call `$io->flush` first if necessary.

### Error Handling
- **Check for errors**: Use `$io->error` to detect if any errors have occurred since the handle was opened or since the last reset.
- **Reset state**: Use `$io->clearerr` to clear the error indicator, allowing subsequent I/O attempts on a recovered handle.

### Low-Level Operations
- **File Descriptors**: Use `$io->fileno` to retrieve the underlying system file descriptor for use with system calls or other low-level modules.
- **Direct I/O**: Use `$io->sysread` and `$io->syswrite` for unbuffered I/O operations when you need to bypass Perl's internal buffering for performance or specific protocol requirements.

## Reference documentation
- [IO::Handle - supply object methods for I/O handles](./references/metacpan_org_pod_IO__Handle.md)
- [perl-io-handle Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_perl-io-handle_overview.md)