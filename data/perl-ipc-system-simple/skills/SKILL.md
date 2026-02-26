---
name: perl-ipc-system-simple
description: This tool executes external commands in Perl with automatic error handling and shell avoidance. Use when user asks to execute system commands, capture command output, or manage process exit codes with descriptive exceptions.
homepage: http://metacpan.org/pod/IPC::System::Simple
---


# perl-ipc-system-simple

## Overview
This skill enables the use of the `IPC::System::Simple` Perl module to manage external process execution. Unlike standard Perl execution methods which require manual checking of the `$?` variable and complex error string formatting, this tool throws descriptive exceptions automatically if a command fails or returns an unexpected exit code. It is ideal for scripts where "fail-fast" behavior and security (via shell avoidance) are priorities.

## Core Functions

### Reliable Command Execution
Use `system` or `run` (they are aliases) to execute commands. They will `die` with a detailed message if the command fails.

```perl
use IPC::System::Simple qw(system);

# Simple execution (uses shell if string contains metacharacters)
system("tar -czf backup.tar.gz /data");

# Multi-argument execution (avoids shell, safer for user-provided data)
system("tar", "-czf", "backup.tar.gz", $directory);
```

### Capturing Output
Use `capture` as a drop-in replacement for backticks or `qx()`.

```perl
use IPC::System::Simple qw(capture);

# Scalar context: returns entire output
my $output = capture("ls", "-l");

# List context: returns list of lines (split on $/)
my @lines = capture("grep", "pattern", "file.txt");
```

### Guaranteed Shell Avoidance
To ensure the shell is **never** invoked, even with a single argument or an empty argument list, use the `x` variants.

```perl
use IPC::System::Simple qw(systemx capturex);

# Guaranteed no shell, even if @args is empty
systemx($command, @args);

# Safe capture
my $data = capturex("cat", $filename);
```

## Advanced Usage

### Custom Exit Values
By default, these functions expect an exit value of `0`. You can specify a list of acceptable exit values as the first argument (in an array reference).

```perl
use IPC::System::Simple qw(system EXIT_ANY);

# Accept 0, 1, or 2 as success
system([0, 1, 2], "diff", $file1, $file2);

# Accept any exit value without dying
system(EXIT_ANY, "some_unreliable_command");
```

### Exception Handling
Since the module throws exceptions, use `eval` or a module like `Try::Tiny` to catch errors gracefully.

```perl
use IPC::System::Simple qw(system);

eval {
    system("some_command");
};
if ($@) {
    warn "Command failed: $@";
}
```

### Accessing Exit Status
The module provides the `$EXITVAL` variable to retrieve the numerical exit code of the last command executed.

```perl
use IPC::System::Simple qw(system $EXITVAL);

system([0..5], "my_script.sh");
print "Script finished with exit code: $EXITVAL\n";
```

## Best Practices
- **Prefer `systemx` and `capturex`**: Use these when passing variables as arguments to prevent shell injection vulnerabilities.
- **Import only what you need**: To avoid namespace pollution, specify functions in the `use` statement: `use IPC::System::Simple qw(systemx capturex);`.
- **Use for Cleanup**: It is excellent for cleanup tasks in scripts where you want the script to abort if a critical file deletion or move fails.

## Reference documentation
- [IPC::System::Simple - Run commands simply, with detailed diagnostics](./references/metacpan_org_pod_IPC__System__Simple.md)