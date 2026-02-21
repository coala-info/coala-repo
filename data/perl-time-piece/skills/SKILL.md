---
name: perl-time-piece
description: The `Date::Easy` module is a high-level wrapper for `Time::Piece` designed to make date handling in Perl more intuitive.
homepage: https://github.com/barefootcoder/date-easy
---

# perl-time-piece

## Overview
The `Date::Easy` module is a high-level wrapper for `Time::Piece` designed to make date handling in Perl more intuitive. It distinguishes between "dates" (fixed at midnight UTC) and "datetimes" (local time with second precision). This skill helps you leverage its simplified constructors, human-readable parsing capabilities, and overloaded arithmetic operators to write cleaner, less error-prone temporal code.

## Core Usage Patterns

### Object Construction
*   **Current Time**: Use `today` for a date object (midnight) or `now` for a datetime object.
*   **Parsing**: Use `date("string")` or `datetime("string")`. The module automatically tries `Date::Parse` and `Time::ParseDate` formats.
*   **Timezones**: 
    *   `date` objects are always UTC.
    *   `datetime` objects default to the local timezone.
    *   Force UTC globally: `use Date::Easy 'UTC';`

### Date Arithmetic
The module overloads addition and subtraction based on the object type:
*   **Date objects**: Integers represent **days**.
    ```perl
    my $tomorrow = today + 1;
    my $last_week = today - 7;
    ```
*   **Datetime objects**: Integers represent **seconds**.
    ```perl
    my $in_an_hour = now + 3600;
    ```
*   **Unit-based math**: Use the units interface for clarity.
    ```perl
    use Date::Easy;
    say today + 3 * months;
    say now - 2 * hours;
    ```

## Best Practices and Expert Tips

### Type Consistency
Always remember that `date` objects strip time information. If you parse a string containing a time into a `date` object, the time is ignored and set to midnight UTC. Use `datetime` if you need to preserve hours, minutes, or seconds.

### Epoch Limits
*   **64-bit systems**: Supports dates from 1-Jan-1000 to 31-Dec-2899.
*   **32-bit systems**: Limited to the standard Unix epoch (1901–2038) unless using Perl 5.12+.

### Stringification
`Date::Easy` objects inherit from `Time::Piece`. You can use standard `strftime` formats for output:
```perl
say $dt->strftime("%Y-%m-%d %H:%M:%S");
```

### Handling UTC/GMT
`Date::Easy` treats "UTC" and "GMT" as identical. When passing these as arguments to the `datetime` constructor or the `use` statement, it ensures the resulting objects operate in the zero-offset timezone.

## Common Pitfalls
*   **Leap Seconds**: The module does not account for leap seconds.
*   **Language**: Parsing is currently restricted to English month and day names.
*   **Timezone Shifts**: Be careful when converting between `date` and `datetime`. Since `date` is always UTC, converting a local `datetime` near midnight to a `date` might result in a different calendar day if not handled explicitly.

## Reference documentation
- [Date::Easy - easy dates with Time::Piece compatibility](./references/github_com_barefootcoder_date-easy.md)