---
name: perl-devel-stacktrace
description: The perl-devel-stacktrace tool provides an object-oriented interface to capture, filter, and inspect the Perl call stack. Use when user asks to capture a stack trace, filter internal library frames from an error report, or inspect subroutine arguments for debugging.
homepage: http://metacpan.org/release/Devel-StackTrace
metadata:
  docker_image: "quay.io/biocontainers/perl-devel-stacktrace:2.04--pl526_0"
---

# perl-devel-stacktrace

## Overview
The `Devel::StackTrace` module provides an object-oriented interface to the Perl stack trace. Unlike the built-in `caller` function, it encapsulates the entire call stack at a specific point in time, allowing you to pass the trace around as an object, filter out internal library frames, and inspect the arguments passed to each subroutine. It is essential for creating robust error handlers and debugging complex, deeply nested Perl applications.

## Basic Usage Patterns

### Capturing a Trace
To capture the current stack state, instantiate a new object.
```perl
use Devel::StackTrace;

# Capture everything from the current point
my $trace = Devel::StackTrace->new;
```

### Filtering Frames
Use `ignore_package` or `ignore_class` to remove "noise" from the trace, such as logging utilities or error-handling wrappers.
```perl
my $trace = Devel::StackTrace->new(
    ignore_package => [ 'My::Log::Wrapper', 'Try::Tiny' ],
);
```

### Inspecting Frames
Iterate through the trace to access individual frame objects.
```perl
while (my $frame = $trace->next_frame) {
    print "File: " . $frame->filename . "\n";
    print "Line: " . $frame->line . "\n";
    print "Sub:  " . $frame->subroutine . "\n";
}
```

## Expert Tips

- **Argument Inspection**: By default, `Devel::StackTrace` captures arguments passed to subroutines. If you are dealing with large objects or sensitive data, use `no_args => 1` to save memory or `p_args => 0` to prevent stringification of arguments.
- **Stringification**: You can simply print the object `print $trace->as_string` for a quick, human-readable dump of the stack.
- **Frame Limiting**: Use the `frame_filter` option (a coderef) for advanced logic to decide which frames to include based on the frame's hash data.
- **Performance**: Capturing a full stack trace is computationally expensive. Avoid triggering traces in high-frequency loops unless an actual error condition is met.

## Reference documentation
- [Devel::StackTrace Documentation](./references/metacpan_org_release_Devel-StackTrace.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-devel-stacktrace_overview.md)