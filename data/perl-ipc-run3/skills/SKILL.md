---
name: perl-ipc-run3
description: The IPC::Run3 module provides a simple interface for executing child processes with redirected input and output streams. Use when user asks to run subprocesses, capture standard output or error to variables, or redirect streams to files and arrays in Perl.
homepage: http://metacpan.org/pod/IPC::Run3
---


# perl-ipc-run3

## Overview
The `IPC::Run3` module provides a simple, "Perlish" interface for running child processes. While Perl's built-in `system`, `qx//`, and `open3` functions are available, `run3` is preferred for its ability to handle all three standard streams (STDIN, STDOUT, STDERR) simultaneously using various data types (scalars, references, files, or subs) while maintaining portability and speed.

## Core Usage Patterns

### Basic Execution
Always prefer the array reference form for commands to avoid shell injection vulnerabilities and ensure arguments are passed correctly.

```perl
use IPC::Run3;

my @cmd = ('ls', '-l', '/tmp');
run3 \@cmd; # Inherits parent's STDIN, STDOUT, and STDERR
```

### Capturing Output to Scalars
The most common use case is capturing output and errors into Perl variables.

```perl
my ($in, $out, $err);
$in = "input data"; # Data to be sent to child's STDIN

run3 \@cmd, \$in, \$out, \$err;

if ($? == 0) {
    print "Success: $out\n";
} else {
    warn "Command failed with exit code " . ($? >> 8) . ": $err\n";
}
```

### Redirecting to Files and Null
You can pass file names or `\undef` to simulate `/dev/null`.

```perl
# Read from file, discard STDOUT, capture STDERR to variable
run3 \@cmd, "input.txt", \undef, \$err;

# Append mode using options
run3 \@cmd, \undef, "output.log", \undef, { append_stdout => 1 };
```

### Capturing to Arrays
Useful for processing output line-by-line immediately.

```perl
my @lines;
run3 \@cmd, \undef, \@lines;
foreach my $line (@lines) {
    # Each element contains one line including the newline
}
```

## Expert Tips & Best Practices

- **Check `$?`**: `run3` returns true if the execution logic worked, but it does not reflect the child's exit code. Always inspect `$?` (the wait status) to determine if the subprocess succeeded.
- **Combined Streams**: To merge STDOUT and STDERR into a single destination, pass the same reference to both arguments: `run3 \@cmd, \undef, \$both, \$both;`.
- **Binmode**: If handling binary data or specific encodings, use the options hash to set layers: `run3 \@cmd, \$in, \$out, undef, { binmode_stdout => ':raw' };`.
- **Avoid String Commands**: Unless you explicitly need shell features (like globbing or environment variable expansion), avoid `run3 "command string"`. Use the array ref `\@cmd` to ensure arguments with spaces are handled correctly.
- **Large Data**: For extremely large I/O, `IPC::Run3` spools data through temporary files or pipes. If you need true asynchronous non-blocking I/O, consider the heavier `IPC::Run` module instead.

## Reference documentation
- [IPC::Run3 - run a subprocess with input/output redirection](./references/metacpan_org_pod_IPC__Run3.md)