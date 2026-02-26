---
name: perl-io-tty
description: The perl-io-tty package provides low-level Perl interfaces for pseudo-terminal allocation and terminal constant management. Use when user asks to allocate a pseudo-tty, automate interactive command-line tools, or bypass errors requiring a terminal environment.
homepage: http://metacpan.org/pod/IO-Tty
---


# perl-io-tty

## Overview
The `perl-io-tty` package (comprising `IO::Tty` and `IO::Pty`) is the fundamental Perl library for pseudo-terminal allocation. It enables a process to create a "master" terminal that controls a "slave" terminal, effectively tricking programs into behaving as if they are connected to a real physical terminal. This is essential for automating software that mandates interactive input (like password prompts) or produces specific behavior only when a TTY is detected (like colored logs or progress bars).

## Usage Patterns and Best Practices

### Basic Pty Allocation
To create a new pseudo-terminal pair, use `IO::Pty`. The master side is used by your script to read and write, while the slave side is assigned to the child process.

```perl
use IO::Pty;

my $pty = IO::Pty->new();
my $slave = $pty->slave();

my $pid = fork();
die "Fork failed" unless defined $pid;

if ($pid == 0) {
    # Child process: Establish the slave as the controlling terminal
    $pty->make_slave_controlling_terminal();
    
    open(STDIN, "<&", $slave);
    open(STDOUT, ">&", $slave);
    open(STDERR, ">&", $slave);
    close($slave);
    
    exec("interactive_tool_name");
}

# Parent process: Close the slave handle and interact via $pty
close($slave);
print $pty "input_to_tool\n";
while (<$pty>) {
    print "Tool output: $_";
}
```

### Handling Terminal Constants
`IO::Tty` exports various POSIX and IOCTL constants. These are used to query or set terminal attributes, such as window size or control characters.

```perl
use IO::Tty qw(TIOCGWINSZ);
# Use with ioctl to get or set window size (winsize)
```

### Expert Tips
- **Bypassing "Not a TTY" Errors**: If a bioinformatics tool or CLI utility fails in a headless environment with a "not a tty" error, use `IO::Pty` to wrap the execution. This provides the necessary terminal interface to satisfy the tool's requirements.
- **File Descriptor Management**: Always close the slave file handle in the parent process immediately after forking. Failure to do so can cause the parent to hang while waiting for an EOF that will never come because the parent itself still holds a reference to the slave.
- **Relationship with Expect**: `IO::Tty` is the low-level dependency for the `Expect.pm` module. For complex automation involving regex-based response patterns, it is often more efficient to use `Expect` rather than raw `IO::Pty` calls.
- **Terminal Emulation**: Note that `IO::Tty` provides the communication channel but does not interpret terminal escape sequences (like ANSI colors or cursor movements). If you need to maintain a virtual screen state, pipe the output of `IO::Tty` into a module like `Term::VT102`.

## Reference documentation
- [IO::Tty - Pseudo ttys and constants](./references/metacpan_org_pod_IO-Tty.md)
- [Bioconda perl-io-tty Overview](./references/anaconda_org_channels_bioconda_packages_perl-io-tty_overview.md)