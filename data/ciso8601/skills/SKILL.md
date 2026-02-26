---
name: ciso8601
description: ciso8601 is a C-based Python extension that provides high-performance parsing of ISO8601 strings into datetime objects. Use when user asks to parse ISO8601 timestamps, convert date strings to Python datetime objects, or optimize timestamp parsing speed for large datasets.
homepage: https://github.com/elasticsales/ciso8601
---


# ciso8601

## Overview

ciso8601 is a C-based Python extension that provides ultra-fast parsing of ISO8601 strings into Python `datetime` objects. It is significantly faster than standard library alternatives and other third-party parsers like `python-dateutil`. Use this tool when you are handling large datasets or real-time streams where timestamp conversion speed is critical.

## Usage Instructions

### Basic Parsing
The primary function is `parse_datetime`, which converts a string into a `datetime.datetime` object.

```python
import ciso8601

# Parsing a standard ISO8601 string
dt = ciso8601.parse_datetime('2024-05-20T12:30:45.123456-05:00')

# Parsing a compact format
dt_compact = ciso8601.parse_datetime('20240520T123045')
```

### Handling Time Zones
*   **Aware Datetimes**: If the input string contains a timezone offset (e.g., `-05:00` or `Z`), the function returns an "aware" datetime object with `tzinfo` set.
*   **Naive Datetimes**: If no timezone information is present in the string, it returns a "naive" datetime object.

### Error Handling
ciso8601 is strict. If a string does not conform to the supported ISO8601 subset, it will raise a `ValueError`. Always wrap calls in a try-except block when dealing with untrusted or messy data.

```python
try:
    dt = ciso8601.parse_datetime(timestamp_string)
except ValueError as e:
    print(f"Invalid ISO8601 string: {e}")
```

### Performance Best Practices
*   **Batch Processing**: Use ciso8601 within list comprehensions or map functions when processing large arrays of strings to leverage its C-speed.
*   **Python Versioning**: While ciso8601 is faster across all versions, the performance gap is most significant in Python versions prior to 3.11. In 3.11+, always benchmark against `datetime.fromisoformat` to ensure the external dependency is justified for your specific use case.

## Reference documentation
- [ciso8601 GitHub Repository](./references/github_com_closeio_ciso8601.md)
- [ciso8601 Bioconda Overview](./references/anaconda_org_channels_bioconda_packages_ciso8601_overview.md)