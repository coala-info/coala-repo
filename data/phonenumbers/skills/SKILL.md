---
name: phonenumbers
description: The `phonenumbers` skill provides a Python-based interface for handling international phone numbers, based on Google's libphonenumber library.
homepage: https://github.com/daviddrysdale/python-phonenumbers
---

# phonenumbers

## Overview
The `phonenumbers` skill provides a Python-based interface for handling international phone numbers, based on Google's libphonenumber library. It allows for the conversion of raw strings into structured `PhoneNumber` objects, which can then be validated against regional rules, formatted for display or storage, and enriched with metadata such as geographic location, carrier names, and time zones.

## Core Workflows

### Parsing and Validation
To work with a number, you must first parse it. If the number is not in global E.164 format (starting with +), you must provide a ISO 3166-1 alpha-2 region code (e.g., "US", "GB").

```python
import phonenumbers

# Parse a number
number = phonenumbers.parse("+442083661177", None)
local_number = phonenumbers.parse("020 8366 1177", "GB")

# Validation
is_possible = phonenumbers.is_possible_number(number)  # Quick check based on length
is_valid = phonenumbers.is_valid_number(number)      # Deep check against known prefixes
```

### Formatting
Standardize numbers for databases or user interfaces using `PhoneNumberFormat`.

*   **E164**: `+442083661177` (Best for database storage)
*   **INTERNATIONAL**: `+44 20 8366 1177`
*   **NATIONAL**: `020 8366 1177`

```python
from phonenumbers import PhoneNumberFormat
formatted = phonenumbers.format_number(number, PhoneNumberFormat.E164)
```

### Metadata Extraction
Retrieve geographic, carrier, and timezone information. These require importing specific submodules.

```python
from phonenumbers import geocoder, carrier, timezone

# Get Location (requires language code)
location = geocoder.description_for_number(number, "en")

# Get Carrier
service_provider = carrier.name_for_number(number, "en")

# Get Timezones
zones = timezone.time_zones_for_number(number)
```

### Finding Numbers in Text
Use `PhoneNumberMatcher` to extract numbers from unstructured strings.

```python
text = "Contact us at 510-748-8230 or 703-480-0500"
for match in phonenumbers.PhoneNumberMatcher(text, "US"):
    print(match.number)
    print(f"Found at: {match.start} to {match.end}")
```

## Best Practices
- **Always use E.164 for storage**: It ensures global uniqueness and simplifies future parsing.
- **Handle Exceptions**: Wrap `parse` calls in a `try-except` block for `NumberParseException` to handle invalid inputs or unsupported regions.
- **Check Validity, not just Possibility**: `is_possible_number` is faster but only checks if the length is correct for the region. `is_valid_number` confirms the number belongs to an actual assigned range.
- **Specify Regions**: When parsing user input from a web form, always pass the user's detected or selected country code to the `region` parameter.

## Reference documentation
- [Python-phonenumbers Main Documentation](./references/github_com_daviddrysdale_python-phonenumbers.md)