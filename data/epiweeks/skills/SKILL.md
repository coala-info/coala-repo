---
name: epiweeks
description: The epiweeks tool calculates and manipulates epidemiological weeks and years using the US CDC or ISO 8601 systems. Use when user asks to convert calendar dates to epidemiological weeks, calculate week boundary dates, or perform arithmetic on reporting periods.
homepage: https://github.com/dralshehri/epiweeks
metadata:
  docker_image: "quay.io/biocontainers/epiweeks:2.4.0--pyhdfd78af_0"
---

# epiweeks

## Overview
The `epiweeks` skill provides specialized functionality for handling epidemiological calendars. It is designed for public health researchers and data scientists who must align surveillance data with standardized reporting periods. Use this skill to convert calendar dates into epidemiological weeks, calculate the precise start and end dates for specific weeks, and perform arithmetic on time periods within the US CDC (MMWR) or ISO 8601 numbering systems.

## Installation
Install the package using one of the following commands:
- **pip**: `pip install epiweeks`
- **conda**: `conda install bioconda::epiweeks`
- **uv**: `uv add epiweeks`

## Core Usage Patterns

### Working with Weeks
The `Week` object is the primary interface for individual week calculations. By default, it uses the US CDC (MMWR) system.

```python
from epiweeks import Week

# Initialize a specific week (Year, Week Number)
w = Week(2023, 1)

# Get boundary dates
print(w.startdate())  # First day of the week
print(w.enddate())    # Last day of the week

# Create from a standard python date object
from datetime import date
w = Week.fromdate(date(2023, 5, 15), system='cdc')
```

### Working with Years
The `Year` object allows for year-level metadata and iteration.

```python
from epiweeks import Year

y = Year(2024)
print(y.number_of_weeks()) # Returns 52 or 53 depending on the year

# Iterate through all weeks in a year
for w in y.iterweeks():
    print(w)
```

### Switching Between Systems
`epiweeks` supports both `cdc` (default) and `iso` systems. Ensure you specify the system if your data source follows ISO 8601 standards.

```python
# ISO Week
w_iso = Week(2023, 1, system='iso')

# CDC Week (MMWR)
w_cdc = Week(2023, 1, system='cdc')
```

## Expert Tips & Best Practices
- **Rich Comparisons**: You can compare `Week` objects directly using standard operators (`<`, `>`, `==`, etc.). This is highly useful for filtering dataframes or lists of surveillance records.
- **Week Arithmetic**: The library supports logical operations. You can add or subtract integers from a `Week` object to navigate through time (e.g., `Week(2023, 1) + 5` returns `Week(2023, 6)`).
- **Validation**: Use the library to validate incoming data. If an invalid week number is provided for a specific year (e.g., Week 53 in a 52-week year), the library will raise a `ValueError`.
- **Surveillance Alignment**: Always verify if your dataset uses the CDC system (weeks start on Sunday) or the ISO system (weeks start on Monday) before performing conversions, as this is a common source of one-day offsets in public health reporting.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_dralshehri_epiweeks.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_epiweeks_overview.md)