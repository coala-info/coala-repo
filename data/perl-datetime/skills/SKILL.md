---
name: perl-datetime
description: The `perl-datetime` skill provides a high-level, object-oriented approach to handling dates and times in Perl, far exceeding the capabilities of the built-in `localtime` and `gmtime` functions.
homepage: https://metacpan.org/dist/DateTime
---

# perl-datetime

## Overview
The `perl-datetime` skill provides a high-level, object-oriented approach to handling dates and times in Perl, far exceeding the capabilities of the built-in `localtime` and `gmtime` functions. It treats time as a discrete object, allowing for seamless math across different timezones and calendars while accounting for complexities like leap seconds and daylight savings time.

## Installation
In bioinformatics environments or managed environments, install via Bioconda:
```bash
conda install bioconda::perl-datetime
```
For standard Perl environments, use CPAN:
```bash
cpan DateTime
```

## Core Usage Patterns

### Object Creation
Always prefer explicit parameter naming for clarity.
```perl
use DateTime;

# Current time
my $dt = DateTime->now( time_zone => 'local' );

# Specific date
my $dt2 = DateTime->new(
    year       => 2025,
    month      => 8,
    day        => 15,
    hour       => 12,
    minute     => 0,
    second     => 0,
    time_zone  => 'UTC',
);
```

### Date Arithmetic
Use the `add` and `subtract` methods. These modify the object in place.
```perl
$dt->add( days => 7, hours => 3 );
$dt->subtract( months => 1 );

# Calculating duration between two objects
my $duration = $dt2->delta_ms($dt);
print $duration->weeks;
```

### Formatting and Output
The `strftime` method follows standard Unix formatting conventions.
```perl
print $dt->ymd;           # 2025-08-15
print $dt->hms;           # 12:00:00
print $dt->strftime('%A, %d %B %Y'); # Friday, 15 August 2025
```

### Comparison
DateTime objects can be compared using Perl's numeric comparison operators because they overload them.
```perl
if ( $dt1 < $dt2 ) {
    print "dt1 is earlier than dt2";
}

my $cmp = DateTime->compare( $dt1, $dt2 ); # Returns -1, 0, or 1
```

## Expert Tips
- **Immutability**: By default, `add()` and `subtract()` modify the original object. To keep the original, use `my $new_dt = $dt->clone->add( days => 1 );`.
- **Timezone Floating**: If no timezone is specified, the object is "floating." This is useful for abstract dates (like "New Year's Day") but dangerous for specific events. Always specify `time_zone => 'UTC'` or `'local'` for real-world events.
- **Epoch Conversion**: To interface with system timestamps, use `DateTime->from_epoch( epoch => $epoch )` and `$dt->epoch`.

## Reference documentation
- [DateTime Overview](./references/anaconda_org_channels_bioconda_packages_perl-datetime_overview.md)
- [MetaCPAN DateTime Main](./references/metacpan_org_dist_DateTime.md)