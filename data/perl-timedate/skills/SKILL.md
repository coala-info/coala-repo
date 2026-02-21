---
name: perl-timedate
description: The `perl-timedate` skill provides a specialized toolkit for handling temporal data within the Perl ecosystem.
homepage: http://metacpan.org/pod/TimeDate
---

# perl-timedate

## Overview
The `perl-timedate` skill provides a specialized toolkit for handling temporal data within the Perl ecosystem. Unlike the core `localtime` functions, this suite excels at "fuzzy" parsing of natural language date strings and RFC-compliant headers (like those found in emails or HTTP responses). It is the standard choice for developers needing to convert human-readable dates into Unix seconds or vice versa with high reliability and time zone awareness.

## Core Module Usage

### Date::Parse (Parsing Strings to Timestamps)
Use `str2time` to convert almost any date string into a Unix timestamp.
```perl
use Date::Parse;

my $time = str2time("25 Oct 2023 12:30:00 +0500");
my $iso  = str2time("2023-10-25T12:30:00");
```

### Date::Format (Formatting Timestamps)
Use `time2str` for formatting. It uses `strftime` style placeholders but is often faster and more portable.
```perl
use Date::Format;

# Common patterns:
# %Y-%m-%d : ISO Date
# %C       : Full date string
# %o       : Day of month with ordinal suffix (1st, 2nd, etc.)
print time2str("%Y-%m-%d %H:%M:%S", time);
```

### Time::Zone (Timezone Offsets)
Use this to determine the offset in seconds for specific timezone identifiers.
```perl
use Time::Zone;

my $offset = tz_local_offset(); # Local offset from UTC
my $pst    = tz_offset("PST");  # Offset for specific zone
```

## Expert Tips & Best Practices
- **Fuzzy Parsing**: `Date::Parse` is highly tolerant. If you are dealing with legacy logs or inconsistent user input, try `str2time` before resorting to complex regular expressions.
- **Language Support**: For multi-language date formatting (e.g., month names in French or German), use the `Date::Language` module included in this suite:
  ```perl
  use Date::Language;
  my $lang = Date::Language->new('French');
  print $lang->time2str("%a %b %e %Y", time);
  ```
- **Performance**: If formatting the same pattern repeatedly in a loop, `Date::Format` is generally more efficient than calling the system `date` command via shell.
- **Mail Headers**: This tool is the "gold standard" for parsing `Resent-Date` and `Date` headers in email processing scripts.

## Reference documentation
- [TimeDate - MetaCPAN](./references/metacpan_org_pod_TimeDate.md)