---
name: perl-date-manip
description: This tool provides a comprehensive interface for parsing, manipulating, and performing arithmetic on complex date and time strings. Use when user asks to parse natural language dates, calculate business day offsets, determine time intervals, or compare timestamps.
homepage: https://metacpan.org/pod/Date::Manip
metadata:
  docker_image: "quay.io/biocontainers/perl-date-manip:6.98--pl5321hdfd78af_0"
---

# perl-date-manip

## Overview
The `perl-date-manip` skill provides a robust interface for handling virtually any date or time operation. Unlike simpler libraries, it is designed to be a "Swiss Army knife" for dates, capable of parsing highly flexible natural language strings, calculating business-day offsets, and managing complex recurring schedules. It is particularly useful for bioinformaticians and system administrators who need to process timestamps in diverse formats or calculate intervals between experimental events.

## Common CLI Patterns
Since `Date::Manip` is a Perl module, its "CLI" usage typically involves Perl one-liners. Use these patterns for quick terminal-based calculations:

### Parsing and Formatting Dates
Convert natural language or specific formats into standard outputs:
```bash
# Parse "today" and format as YYYY-MM-DD
perl -MDate::Manip -e 'print UnixDate("today", "%Y-%m-%d")'

# Parse a complex string
perl -MDate::Manip -e 'print UnixDate("1st thursday in June 2025", "%Y-%m-%d")'
```

### Date Arithmetic (Deltas)
Calculate a new date based on an offset:
```bash
# Add 3 business days to a specific date
perl -MDate::Manip -e 'print UnixDate(DateCalc("2023-12-01", "+ 3 business days"), "%Y-%m-%d")'

# Calculate the time between two dates
perl -MDate::Manip -e 'print DateCalc("2023-01-01", "2023-12-25")'
```

### Date Comparison
Determine the chronological order of two date strings:
```bash
# Returns -1 if first is earlier, 0 if equal, 1 if later
perl -MDate::Manip -e 'print Date_Cmp("2023-05-01", "2023-04-20")'
```

## Expert Tips and Best Practices
- **Natural Language Parsing**: `ParseDate` is extremely forgiving. It can handle strings like "last Monday," "noon yesterday," or "3 weeks ago Friday."
- **Business Days**: Use the `business` keyword in deltas to skip weekends and holidays. Note that holiday definitions can be customized in the `Date::Manip` configuration.
- **Format Codes**: 
    - `%Y`, `%m`, `%d`: Standard Year, Month, Day.
    - `%H`, `%M`, `%S`: Hour, Minute, Second.
    - `%j`: Day of the year.
    - `%U`: Week number.
- **Performance**: `Date::Manip` is feature-rich but can be slower than lighter modules like `Time::Piece`. Use it when complexity (like business days or complex recurrences) justifies the overhead.
- **Time Zones**: By default, the module uses the system time zone. Use `Date::Manip::TZ` directly if you need to perform conversions between specific zones like `UTC` and `EST`.

## Reference documentation
- [Date::Manip Overview](./references/metacpan_org_pod_Date__Manip.md)
- [Bioconda Package Overview](./references/anaconda_org_channels_bioconda_packages_perl-date-manip_overview.md)