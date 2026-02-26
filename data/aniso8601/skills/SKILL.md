---
name: aniso8601
description: "aniso8601 is a Python library for parsing ISO 8601 strings into native Python date and time objects. Use when user asks to parse ISO 8601 strings, handle fractional time elements, convert durations and intervals to Python objects, or process repeating date patterns."
homepage: https://github.com/sloanlance/aniso8601
---


# aniso8601

## Overview
aniso8601 is a pure-Python library that provides logical and consistent parsing of ISO 8601 strings. While Python's built-in datetime module handles basic ISO formats, aniso8601 is required for advanced use cases including fractional time elements, UTC offsets in time-only strings, and complex duration or interval logic. It transforms strings into native Python types like `datetime.datetime`, `datetime.timedelta`, or generators for repeating patterns.

## Core Parsing Patterns

### Datetimes and Dates
Parse standard ISO 8601 datetime strings, including those with custom delimiters or UTC offsets.

```python
import aniso8601

# Standard datetime
dt = aniso8601.parse_datetime('1977-06-10T12:00:00Z')

# Custom delimiter (e.g., space instead of T)
dt_space = aniso8601.parse_datetime('1977-06-10 12:00:00Z', delimiter=' ')

# Week date format
date = aniso8601.parse_date('1986-W38-1') # Returns datetime.date(1986, 9, 15)

# Ordinal date
date_ordinal = aniso8601.parse_date('1988-132') # Returns datetime.date(1988, 5, 11)
```

### Durations
Durations can be parsed into `timedelta` objects. By default, years are treated as 365 days and months as 30 days.

```python
# Standard duration
duration = aniso8601.parse_duration('P1Y2M3DT4H54M6S')

# Fractional elements (allowed on the lowest order element)
fractional = aniso8601.parse_duration('P1YT3.5M')
```

### Intervals
Intervals return a tuple of date or datetime objects.

```python
# Start and End
interval = aniso8601.parse_interval('2007-03-01T13:00:00/2008-05-11T15:30:00')

# Start and Duration
interval_dur = aniso8601.parse_interval('2007-03-01T13:00:00Z/P1Y2M10DT2H30M')
```

## Expert Tips and Best Practices

### Calendar Accuracy with relative=True
If you need calendar-specific accuracy (e.g., adding a month to January 31st resulting in February 28th), use the `relative` keyword. This requires `python-dateutil` to be installed to return `relativedelta`.

```python
# Returns a relativedelta object instead of timedelta
one_month = aniso8601.parse_duration('P1M', relative=True)
```
*Note: Fractional months or years are not supported when `relative=True`.*

### Handling Repeating Intervals
Repeating intervals return a Python generator, making them memory-efficient for large or infinite series.

```python
# R[limit]/[interval]
repeater = aniso8601.parse_repeating_interval('R5/1977-06-10T12:00:00Z/P1D')
for dt in repeater:
    print(dt)
```

### Sorting Intervals
The library preserves the order defined in the string. If an interval is defined as `Duration/End`, the resulting tuple will be `(End, Start)`. Use `sorted()` if chronological order is required.

```python
# Ensure chronological order
sorted_interval = sorted(aniso8601.parse_interval('P1M/1981-04-05'))
```

### Limitations: Leap Seconds
aniso8601 does not support leap seconds. Attempting to parse a time with `60` seconds will raise a `ValueError`. Always wrap parsing in a try-except block when dealing with external high-precision data.

## Reference documentation
- [aniso8601 Main Documentation](./references/github_com_sloanlance_aniso8601.md)