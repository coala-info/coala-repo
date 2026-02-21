---
name: perl-sys-sigaction
description: `Sys::SigAction` provides a consistent interface for POSIX signal handling in Perl.
homepage: http://metacpan.org/pod/Sys::SigAction
---

# perl-sys-sigaction

## Overview
`Sys::SigAction` provides a consistent interface for POSIX signal handling in Perl. It is primarily used to overcome the limitations of Perl's "safe signals" (deferred signals) introduced in version 5.8.0, which can cause blocking system calls to be automatically retried instead of being interrupted by an `ALRM`. This skill helps you implement robust timeouts and scoped signal handlers that automatically reset when they go out of scope.

## Core Functions

### Scoped Signal Handling
Use `set_sig_handler()` to define a handler that exists only within a specific lexical scope. The handler is restored to its previous state when the returned object is destroyed.

```perl
use Sys::SigAction qw( set_sig_handler );

{
    # Handler is set here
    my $h = set_sig_handler( 'INT', sub { die "Interrupted!\n" } );
    # ... perform work ...
} 
# Handler is automatically restored to previous value here
```

### Implementing Timeouts
The `timeout_call()` function is the most efficient way to wrap a block of code with a timer. It supports sub-second resolution if `Time::HiRes` is available.

```perl
use Sys::SigAction qw( timeout_call );

my $timeout = 2.5; # Seconds (supports floating point)
my $code = sub {
    # Blocking operation here
    return $dbh->connect(...);
};

if ( timeout_call( $timeout, $code ) ) {
    print "The operation timed out.\n";
} else {
    print "Operation completed successfully.\n";
}
```

### Manual Timeout with POSIX sigaction
For more control, use `set_sig_handler` with the `safe` flag set to `0` to ensure a system call is actually interrupted.

```perl
use Sys::SigAction qw( set_sig_handler );

eval {
    my $h = set_sig_handler( 'ALRM', sub { die "timeout" }, { safe => 0 } );
    eval {
        alarm(5);
        # This system call will now correctly throw EINTR on alarm
        my $data = <$socket>;
        alarm(0);
    };
    alarm(0);
    die $@ if $@;
};
if ($@ =~ /timeout/) { ... }
```

## Best Practices
- **Prefer `timeout_call`**: It handles the `eval`/`alarm` boilerplate and `Time::HiRes` integration automatically.
- **Use `safe => 0` for Timeouts**: When using Perl 5.8.0 or later, set the `safe` attribute to `0` to bypass deferred signals if you need to interrupt a blocking library call (like `DBI->connect`).
- **Avoid Global State**: Always assign the result of `set_sig_handler()` to a `my` variable to ensure the signal handler is cleaned up via RAII (Resource Acquisition Is Initialization).
- **Signal Names vs. Numbers**: Use `sig_number('NAME')` and `sig_name(number)` for portable signal translation.

## Reference documentation
- [Sys::SigAction - Perl extension for Consistent Signal Handling](./references/metacpan_org_pod_Sys__SigAction.md)