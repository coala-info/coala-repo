---
name: perl-test-trap
description: The `perl-test-trap` skill provides a sophisticated mechanism for "trapping" the side effects of Perl code blocks.
homepage: https://metacpan.org/pod/Test::Trap
---

# perl-test-trap

## Overview
The `perl-test-trap` skill provides a sophisticated mechanism for "trapping" the side effects of Perl code blocks. Unlike a standard `eval`, which only captures exceptions, this tool intercepts return values, warnings, output streams, and even process termination signals. It stores these results in a dedicated `$trap` object, allowing for granular assertions in a test suite. This is the preferred tool for testing CLI-like behavior within Perl modules or ensuring that error-handling logic produces the correct user-facing messages and exit statuses.

## Core Usage Patterns

### Basic Trapping
To capture the output and behavior of a block, wrap the code in a `trap` block. By default, this exports the `trap` function and the `$trap` result object.

```perl
use Test::More;
use Test::Trap;

# Trap a block of code
my @results = trap { 
    print "Hello World";
    warn "A warning occurred";
    exit 10;
};

# Inspect the results using the $trap object
is($trap->exit, 10, "Caught correct exit code");
is($trap->stdout, "Hello World", "STDOUT captured");
like($trap->warn(0), qr/warning/, "First warning matches pattern");
```

### Controlling Trap Layers
Layers define what the trap intercepts. The default is `:raw:die:exit:stdout:stderr:warn`.

- **Flow Control**: Use `:flow` as a shortcut for `:raw:die:exit`.
- **Context**: Force the block to run in a specific context using `:scalar`, `:list`, or `:void`.
- **Custom Selection**: `use Test::Trap qw/ :stderr :die /;` will only trap standard error and exceptions.

### Capturing System Calls and Forks
Standard capture strategies often fail to intercept output from `system()` calls or forked processes. Use the `systemsafe` strategy for these scenarios.

```perl
use Test::Trap qw/ :stdout(systemsafe) :stderr(systemsafe) /;

trap { system("echo 'External output'") };
is($trap->stdout, "External output\n", "Captured output from system call");
```

## Result Accessors and Tests
The `$trap` object provides both data accessors and built-in Test::More-compatible methods.

### Accessors
- `$trap->leaveby`: Returns how the block finished ('return', 'die', or 'exit').
- `$trap->die`: Returns the exception message if the block died.
- `$trap->exit`: Returns the exit code.
- `$trap->stdout` / `$trap->stderr`: Returns the captured strings.
- `$trap->warn`: Returns a list of warnings (or a specific index if provided).

### Built-in Test Methods
These methods automatically generate Test::More output:
- `$trap->accessor_is($expected, $name)`: e.g., `$trap->exit_is(0, "Exited normally")`.
- `$trap->accessor_like($regex, $name)`: e.g., `$trap->stdout_like(qr/success/, "Output matches")`.
- `$trap->did_die($name)` / `$trap->did_exit($name)`: Quick checks for flow control.

## Expert Tips
- **Layer Ordering**: The `:raw` layer is a terminator. Any layers defined "below" or "after" it in the stack are ignored.
- **Debugging Failures**: Use the `:on_fail(diag_all)` layer to automatically dump all trapped data (STDOUT, STDERR, etc.) whenever a test within the trap's scope fails.
- **Context Propagation**: By default, `trap` propagates the context it was called in. If you call `my $val = trap { ... }`, the block runs in scalar context. If you call `my @vals = trap { ... }`, it runs in list context. Use explicit context layers (`:scalar`, `:list`) if the code under test behaves differently based on context.

## Reference documentation
- [Test::Trap - Trap exit codes, exceptions, output, etc.](./references/metacpan_org_pod_Test__Trap.md)
- [Test::Trap::Builder::SystemSafe - "Safe" capture strategies using File::Temp](./references/metacpan_org_pod_Test__Trap__Builder__SystemSafe.md)