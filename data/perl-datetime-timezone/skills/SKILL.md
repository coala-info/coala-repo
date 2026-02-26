---
name: perl-datetime-timezone
description: This tool provides a standardized interface for managing time zone data and retrieving offsets based on the Olson database within Perl. Use when user asks to create time zone objects, retrieve UTC offsets, check daylight savings status, or list available time zone names.
homepage: https://metacpan.org/release/DateTime-TimeZone
---


# perl-datetime-timezone

## Overview
The `perl-datetime-timezone` skill provides a standardized interface for managing time zone data within the Perl ecosystem. It acts as a factory class that returns specific time zone objects based on Olson database names. Use this tool to ensure that date-time calculations correctly account for historical offset changes and DST transitions without manual offset math.

## Usage Patterns

### Object Instantiation
To create a time zone object, use the `new` method with a valid name.
```perl
use DateTime::TimeZone;

# Create by name
my $tz = DateTime::TimeZone->new( name => 'America/Los_Angeles' );

# Create for local system time zone
my $local_tz = DateTime::TimeZone->new( name => 'local' );

# Create for UTC
my $utc_tz = DateTime::TimeZone->new( name => 'UTC' );
```

### Retrieving Offsets
Offsets are returned in seconds relative to UTC.
```perl
# Get offset for a specific epoch (seconds since 1970-01-01)
my $offset = $tz->offset_for_datetime($dt); 

# Check if a specific time is in Daylight Savings
my $is_dst = $tz->is_dst_for_datetime($dt);
```

### Listing Available Zones
To provide users with choices or validate input:
```perl
my @all_zones = DateTime::TimeZone->all_names;
my @categories = DateTime::TimeZone->categories; # e.g., Africa, America, Asia
```

## Best Practices
- **Always use named zones**: Avoid hardcoding offsets like "+0500" because they do not account for DST changes. Use "Asia/Karachi" instead.
- **Handle 'local' carefully**: On some systems, determining the local time zone can be slow or fail. If performance is critical, cache the result of `DateTime::TimeZone->new( name => 'local' )`.
- **Validation**: Use `DateTime::TimeZone->is_valid_name($string)` to check user input before attempting to instantiate an object to prevent runtime exceptions.
- **Floating Time Zones**: Use the 'floating' time zone for times that don't have a specific zone (like "noon on New Year's Day" regardless of location).

## Reference documentation
- [DateTime::TimeZone - MetaCPAN](./references/metacpan_org_release_DateTime-TimeZone.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-datetime-timezone_overview.md)