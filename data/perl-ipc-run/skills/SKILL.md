---
name: perl-ipc-run
description: The `perl-ipc-run` skill provides a robust framework for process management in Perl, far exceeding the capabilities of standard `system()`, `exec()`, or backticks.
homepage: https://metacpan.org/pod/IPC::Run
---

# perl-ipc-run

## Overview
The `perl-ipc-run` skill provides a robust framework for process management in Perl, far exceeding the capabilities of standard `system()`, `exec()`, or backticks. Use this skill to build "harnesses" that allow for fine-grained control over subprocess lifecycles. It is particularly useful for interactive scripting (Expect-like behavior), where you need to `pump` data into a process and `finish` it based on specific output patterns, or when you need to safely handle command-line arguments on Windows using `Win32Process`.

## Core Usage Patterns

### Simple Execution and Capture
For basic command execution where you need to capture output and errors into scalars:
```perl
use IPC::Run qw( run timeout );

my ($in, $out, $err);
# run() returns true if the command exits with 0
run [ 'command', 'arg1', 'arg2' ], \$in, \$out, \$err, timeout(10)
    or die "Command failed with $?: $err";
```

### Piping and Redirection
`IPC::Run` uses a mini-language for redirections:
- **Piping**: `run \@cmd1, '|', \@cmd2, '|', \@cmd3;`
- **File Redirection**: `run \@cmd, '<', 'input.txt', '>', 'output.txt';`
- **Combined Output**: `run \@cmd, '>&', \$out_and_err;`
- **Append**: `run \@cmd, '>>', 'log.txt';`

### Interactive Subprocesses (Harnesses)
To interact with a process while it is running, use `start`, `pump`, and `finish`:
```perl
use IPC::Run qw( start pump finish );

my $h = start [ 'bc' ], \$in, \$out;
$in = "5 + 5\n";
pump $h until $out =~ /\n/;
print $out; # Outputs 10
$in = "quit\n";
finish $h;
```

### Windows-Specific Command Lines
When dealing with Windows programs that have non-standard parsing (like `cmd.exe` or `cscript.exe`), use `IPC::Run::Win32Process` to pass verbatim strings to `CreateProcess`:
```perl
use IPC::Run qw( run );
use IPC::Run::Win32Process;

run(IPC::Run::Win32Process->new($ENV{COMSPEC}, 'cmd.exe /c echo "hello"'), '>', \$out);
```

## Expert Tips
- **Binary Data**: If passing binary data through scalars, ensure you use `binmode` logic or ensure the scalars aren't being treated as UTF-8 strings to avoid corruption.
- **PTYs**: Use `<pty<` and `>pty>` instead of standard pipes if the subprocess behaves differently when it detects it isn't running in a terminal (e.g., password prompts).
- **Cleanup**: Always call `finish()` on harnesses created with `start()` to avoid zombie processes and to ensure all buffers are flushed.
- **Error Propagation**: Exceptions thrown in an `init => \&sub` block (used for pre-exec setup) are automatically propagated back to the parent process.

## Reference documentation
- [IPC::Run - system() and background procs](./references/metacpan_org_pod_IPC__Run.md)
- [IPC::Run::Win32Process - nonstandard command lines](./references/metacpan_org_pod_IPC__Run__Win32Process.md)
- [IPC::Run::Timer - timeouts and timers](./references/metacpan_org_pod_IPC__Run__Timer.md)