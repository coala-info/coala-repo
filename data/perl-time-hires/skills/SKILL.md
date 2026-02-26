---
name: perl-time-hires
description: This tool provides high-resolution versions of Perl time functions for microsecond or nanosecond precision. Use when user asks to measure execution time, implement sub-second delays, or set fractional timeouts in Perl scripts.
homepage: http://metacpan.org/pod/Time::HiRes
---


# perl-time-hires

## Overview

`perl-time-hires` provides the `Time::HiRes` module, which implements high-resolution versions of standard Perl time functions. While standard Perl typically operates with one-second resolution, this module allows for microsecond or even nanosecond precision. It is the industry standard for performance profiling, precise delays in automation, and handling sub-second timeouts in network or hardware interfacing scripts.

## Implementation Patterns

### High-Resolution Sleeping
Use these functions when you need delays shorter than one second, which the standard `sleep` function cannot provide.

```perl
use Time::HiRes qw(usleep nanosleep sleep);

# Sleep for 0.5 seconds (500,000 microseconds)
usleep(500_000);

# Sleep for 0.1 seconds (100,000,000 nanoseconds)
nanosleep(100_000_000);

# Time::HiRes also overrides standard sleep to accept floats
sleep(0.25);
```

### Measuring Execution Time
To profile code or measure intervals, use `gettimeofday` combined with `tv_interval`.

```perl
use Time::HiRes qw(gettimeofday tv_interval);

# Record start time
my $t0 = [gettimeofday];

# ... run code to be measured ...

# Calculate elapsed time in seconds (as a float)
my $elapsed = tv_interval($t0);
print "Action took $elapsed seconds\n";
```

### Sub-second Alarms
Standard Perl `alarm()` only accepts integer seconds. `Time::HiRes` allows for fractional timeouts.

```perl
use Time::HiRes qw(alarm);
use POSIX qw(SIGALRM);

local $SIG{ALRM} = sub { die "Timeout reached!\n" };

# Set an alarm for 0.1 seconds
alarm(0.1);

eval {
    # ... long running operation ...
    alarm(0); # Clear alarm
};
if ($@ =~ /Timeout reached/) {
    # Handle timeout
}
```

## Best Practices

- **System Limitations**: High-resolution timing is dependent on the underlying operating system and hardware. If the system does not support nanosecond precision, `nanosleep` will fall back to the best available resolution.
- **Importing**: Always explicitly list the functions you want to import in the `use` statement to avoid namespace pollution and ensure clarity.
- **Stat Precision**: If your filesystem supports sub-second timestamps, use `Time::HiRes::stat` instead of the built-in `stat` to retrieve high-resolution access, modification, and change times.
- **Floating Point Math**: When performing calculations with high-res timestamps, be mindful of floating-point precision limits in Perl.

## Reference documentation
- [Time::HiRes - High resolution alarm, sleep, gettimeofday, interval timers](./references/metacpan_org_pod_Time__HiRes.md)
- [perl-time-hires - bioconda | Anaconda.org](./references/anaconda_org_channels_bioconda_packages_perl-time-hires_overview.md)