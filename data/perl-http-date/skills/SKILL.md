---
name: perl-http-date
description: The `perl-http-date` skill provides specialized routines for bridging the gap between human-readable date strings and machine-readable Unix timestamps (seconds since epoch).
homepage: http://metacpan.org/pod/HTTP::Date
---

# perl-http-date

## Overview
The `perl-http-date` skill provides specialized routines for bridging the gap between human-readable date strings and machine-readable Unix timestamps (seconds since epoch). While primarily designed for the HTTP protocol's strict GMT requirements, it is highly versatile and can handle a wide array of common formats found in server logs, directory listings, and legacy systems.

## Core Functions and Usage

### Standard HTTP Formatting
To generate a timestamp for an HTTP header (e.g., `Last-Modified` or `Date`), use `time2str`. It defaults to the current time and always outputs GMT.

```perl
use HTTP::Date;

# Current time in RFC 1123 format (e.g., "Sun, 06 Nov 1994 08:49:37 GMT")
my $http_header_date = time2str();

# Specific epoch time to HTTP string
my $custom_date = time2str(1672531200);
```

### Robust Date Parsing
The `str2time` function is the primary tool for converting strings back to epoch seconds. It is highly "forgiving" and attempts to guess the format.

```perl
use HTTP::Date;

# Parse various formats into machine time
my $time1 = str2time("2023-07-06 22:31:19Z");       # ISO 8601
my $time2 = str2time("03/Feb/1994:17:03:55 -0700"); # Common Log Format
my $time3 = str2time("Feb 3 17:03");                # Unix ls -l format
```

### Detailed Component Extraction
If you need to manipulate specific date parts (year, month, day) rather than just getting a timestamp, use `parse_date`.

```perl
# Returns ($year, $month, $day, $hour, $min, $sec, $tz)
my @parts = parse_date("Thursday, 03-Feb-94 17:03:55 GMT");

# In scalar context, returns "YYYY-MM-DD hh:mm:ss TZ"
my $iso_string = parse_date("03/Feb/1994");
```

## Expert Tips and Best Practices

- **Timezone Handling**: `str2time` assumes the local timezone if no zone is specified in the string. To override this, provide a second argument: `str2time($date_string, 'GMT')`.
- **Two-Digit Years**: When parsing 2-digit years (e.g., "94"), the module automatically selects the century closest to the current date. For absolute precision, always prefer 4-digit years.
- **ISO 8601 Variants**: Use `time2iso($time)` for local time "YYYY-MM-DD hh:mm:ss" or `time2isoz($time)` for UTC "YYYY-MM-DD hh:mm:ssZ".
- **Missing Seconds/Months**: The parser can handle strings where seconds are omitted or where months are represented numerically, making it ideal for cleaning inconsistent data sources.

## Reference documentation
- [HTTP::Date - date conversion routines](./references/metacpan_org_pod_HTTP__Date.md)