---
name: perl-tie-log4perl
description: This skill provides guidance on using the `Tie::Log4perl` module to intercept data written to Perl filehandles and route it through `Log4perl`.
homepage: http://metacpan.org/pod/Tie::Log4perl
---

# perl-tie-log4perl

## Overview
This skill provides guidance on using the `Tie::Log4perl` module to intercept data written to Perl filehandles and route it through `Log4perl`. It is particularly useful for capturing output from external libraries or legacy code that does not natively support logging, allowing you to control that output via standard Log4perl configuration files (levels, appenders, and patterns).

## Implementation Patterns

### Basic Filehandle Tying
To redirect a standard filehandle like `STDOUT` to a specific Log4perl category:

```perl
use Log::Log4perl qw(:easy);
use Tie::Log4perl;

# Initialize Log4perl
Log::Log4perl->easy_init($DEBUG);

# Tie STDOUT to a specific logger category
tie *STDOUT, 'Tie::Log4perl', 'My.Output.Category';

# This now goes to the Log4perl 'My.Output.Category' at INFO level
print "This is now a log message\n";
```

### Specifying Log Levels
By default, `Tie::Log4perl` uses the `info` level. You can specify a different level during the `tie` call:

```perl
# Tie STDERR to the 'Error.Logger' category at the FATAL level
tie *STDERR, 'Tie::Log4perl', 'Error.Logger', 'fatal';

warn "This will be logged as FATAL\n";
```

### Capturing Legacy Script Output
When wrapping a legacy script that uses `print` statements, tie the filehandle before calling the legacy functions:

```perl
{
    local *STDOUT;
    tie *STDOUT, 'Tie::Log4perl', 'Legacy.Script';
    run_legacy_subroutine(); 
    # STDOUT is automatically untied when it goes out of scope
}
```

## Best Practices
- **Scope Management**: Use `local` when tying global filehandles like `STDOUT` or `STDERR` within a subroutine to ensure the redirection is temporary and doesn't affect the rest of the application.
- **Avoid Infinite Loops**: Ensure that the Log4perl appender you are routing to does not itself print to the same filehandle you have tied (e.g., a ScreenAppender printing to a tied STDOUT), as this can cause recursion.
- **Level Mapping**: Map `STDOUT` to `info` or `debug` and `STDERR` to `error` or `warn` to maintain logical log separation.

## Reference documentation
- [Tie::Log4perl Documentation](./references/metacpan_org_pod_Tie__Log4perl.md)