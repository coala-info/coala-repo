---
name: isodate
description: isodate parses and formats ISO 8601 strings into Python datetime objects, including complex durations and time zones. Use when user asks to parse ISO 8601 date strings, handle calendar-based durations, or format datetime objects into ISO 8601 compliant strings.
homepage: https://github.com/gweis/isodate
metadata:
  docker_image: "quay.io/biocontainers/isodate:0.5.4--py36_0"
---

# isodate

## Overview

`isodate` is a specialized Python library designed to bridge the gap between the ISO 8601:2004 standard and Python's native `datetime` types. While Python's standard library offers basic ISO formatting, `isodate` provides robust parsing for the full range of ISO 8601 representations, including durations, time zones, and combined date-time strings. It is the preferred tool when you encounter ISO strings that include calendar-based duration components (like years and months) which the standard `timedelta` object cannot natively represent.

## Core Parsing Functions

The library provides specific functions for different ISO 8601 components. All parsing functions are available at the top level of the module.

- `parse_date(string)`: Returns a `datetime.date` object.
- `parse_time(string)`: Returns a `datetime.time` object.
- `parse_datetime(string)`: Returns a `datetime.datetime` object.
- `parse_duration(string)`: Returns either a `datetime.timedelta` or an `isodate.Duration` object.
- `parse_tzinfo(string)`: Returns a `datetime.tzinfo` object.

## Working with Durations

One of the primary reasons to use `isodate` is its handling of durations (e.g., `P1Y2M10DT15H`).

### The Duration Class
Because Python's `timedelta` only supports days, seconds, and microseconds, `isodate` introduces a `Duration` class to handle years and months.
- If a duration string contains only days or smaller units, `parse_duration` returns a standard `timedelta`.
- If the string contains years or months, it returns an `isodate.Duration` instance.

### Conversion
You can convert a `Duration` to a `timedelta`, but note that this requires an absolute date context to resolve the length of months and years:
```python
duration = isodate.parse_duration('P1M') # 1 month
# To convert to timedelta, you must provide a start date
delta = duration.totimedelta(start=datetime.now())
```

## Formatting to ISO 8601

The library provides formatting methods that default to the ISO 8601 expanded format (e.g., `YYYY-MM-DD`).

- `date_isoformat(date, format=DATE_EXT_COMPLETE)`
- `time_isoformat(time, format=TIME_EXT_COMPLETE)`
- `datetime_isoformat(dt, format=DATETIME_EXT_COMPLETE)`
- `duration_isoformat(duration, format=DURATION_EXT_COMPLETE)`

## Expert Tips and Best Practices

- **Precision Limits**: `isodate` rounds nanoseconds down to microseconds to maintain compatibility with Python's `datetime` objects.
- **Timezone Interpretation**: If no timezone information is present in a time string, `isodate` interprets it as **local time**, not UTC.
- **Strictness**: The library follows ISO 8601:2004 strictly. For example, 2-digit years are not supported as they are not explicitly mentioned in that version of the standard.
- **Mixed Formats**: The parser is flexible enough to handle a mixture of basic (e.g., `20231027`) and extended (e.g., `10:30:00`) formats within the same date-time string.
- **Incomplete Dates**: For incomplete dates (like a century or a year), `isodate` defaults to the first day of that period (e.g., "19" becomes `1901-01-01`).

## Reference documentation

- [ISO 8601 date/time parser README](./references/github_com_gweis_isodate.md)