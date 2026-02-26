---
name: perl-ipc-cmd
description: This Perl module provides a cross-platform interface for executing shell commands and capturing their output. Use when user asks to execute shell commands in Perl, check if an executable exists in the PATH, or capture command output and error streams separately.
homepage: http://metacpan.org/pod/IPC::Cmd
---


# perl-ipc-cmd

## Overview
The `IPC::Cmd` module provides a robust, cross-platform method for executing shell commands within Perl. It abstracts away the differences between operating systems (like quoting requirements and path separators), making it the preferred choice over backticks or `system()` calls when portability and error handling are priorities. It is particularly useful for checking if a binary exists in the user's PATH and capturing both STDOUT and STDERR separately.

## Command Discovery
Before executing a command, verify the executable is available to avoid runtime failures.

```perl
use IPC::Cmd qw(can_run);

my $full_path = can_run('gcc');
if ($full_path) {
    print "Found gcc at: $full_path\n";
} else {
    die "gcc is not installed or not in PATH";
}
```

## Executing Commands
Use `run()` for most execution tasks. It returns a success flag, an error message, the full output array, the STDOUT array, and the STDERR array.

### Basic Execution
```perl
use IPC::Cmd qw(run);

my $cmd = [ 'ls', '-al', '/tmp' ]; # Use array refs for automatic quoting
my ( $success, $error_code, $full_buf, $stdout_buf, $stderr_buf ) = run( command => $cmd );

if ( $success ) {
    print "Command succeeded\n";
    print "Output: " . join("\n", @$stdout_buf);
}
```

### Handling Verbose Output
To stream output directly to the terminal while the command is running, set the `verbose` flag.

```perl
run( command => 'make all', verbose => 1 );
```

## Best Practices
- **Prefer Array References**: Always pass commands as an array reference (e.g., `['tar', '-xzf', 'file.tgz']`) rather than a single string. This bypasses the shell, preventing shell injection vulnerabilities and avoiding complex quoting issues.
- **Timeout Management**: For long-running processes, use the `timeout` parameter to prevent the Perl script from hanging indefinitely.
- **Buffer Management**: If you expect a massive amount of output, be aware that `run()` captures output in memory. For extremely large data streams, consider redirecting to a file instead.
- **Error Checking**: Always check the `$success` return value. If it is false, inspect `$error_code` to determine if the failure was due to the command not existing, a non-zero exit status, or a signal.

## Reference documentation
- [IPC::Cmd - Cross platform search and execution of commands](./references/metacpan_org_pod_IPC__Cmd.md)
- [Bioconda perl-ipc-cmd Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-ipc-cmd_overview.md)