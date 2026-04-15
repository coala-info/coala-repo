---
name: infinity
description: The infinity package provides a specialized object that enables consistent comparisons between infinity and any comparable Python type, including integers, strings, and datetimes. Use when user asks to compare infinity against non-numeric types, implement strict mathematical validation for undefined operations, or use infinity as a sentinel value in algorithms.
homepage: https://github.com/kvesteri/infinity
metadata:
  docker_image: "quay.io/biocontainers/infinity:1.4--py35_0"
---

# infinity

## Overview
The `infinity` package provides a specialized, all-in-one infinity object for Python. While Python's native `float('inf')` is useful for numeric calculations, it often fails or behaves inconsistently when compared against non-float types. This tool provides an `inf` object that can be compared against any comparable Python object, including integers, strings, and datetimes. Additionally, it implements a stricter mathematical model than standard floats, raising `TypeError` for operations that are mathematically undefined, such as subtracting infinity from infinity.

## Installation
The package can be installed via pip or conda:

```bash
pip install infinity
# OR
conda install bioconda::infinity
```

## Core Usage and Best Practices

### Basic Comparisons
The primary advantage of `infinity` is its ability to interact with diverse data types.

```python
from infinity import inf
from datetime import datetime

# Numeric comparison
assert 10**10 < inf
assert -inf < -10**10

# Non-numeric comparison (where float('inf') often fails)
assert datetime(2025, 1, 1) < inf
assert datetime.now() > -inf

# Equality checks
assert inf == inf
assert -inf == -inf
assert inf != -inf
```

### Arithmetic Operations
The `inf` object supports standard arithmetic but enforces strictness for undefined cases.

| Operation | Result |
|-----------|--------|
| `inf + <number>` | `inf` |
| `inf + <datetime>` | `inf` |
| `5 / inf` | `0` |
| `pow(inf, 0.5)` | `inf` |
| `inf - inf` | `TypeError` |
| `inf * 0` | `TypeError` |
| `pow(1, inf)` | `TypeError` |

### Type Coercion
You can easily convert `infinity` objects to standard Python types for compatibility with other libraries:

```python
from infinity import inf

float_inf = float(inf)   # Returns float('inf')
str_inf = str(inf)       # Returns 'inf'
is_true = bool(inf)      # Returns True
```

## Expert Tips
- **Sentinel Values**: Use `inf` as a starting value for "find minimum" algorithms where the data set might contain non-numeric types that support comparison.
- **Strict Validation**: Use this library instead of `math.inf` if your application logic requires an immediate crash (`TypeError`) when an invalid operation occurs, preventing `NaN` values from propagating silently through your system.
- **Database/API Defaults**: When mapping database "infinity" timestamps or values to Python, `infinity.inf` provides a more reliable mapping than `None` or maximum integers, as it maintains correct comparison logic.

## Reference documentation
- [GitHub Repository Overview](./references/github_com_kvesteri_infinity.md)
- [Bioconda Package Details](./references/anaconda_org_channels_bioconda_packages_infinity_overview.md)